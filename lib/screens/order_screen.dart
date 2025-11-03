import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/beverage.dart';
import '../providers/beverage_providers.dart';
import '../tokens.dart';
import '../widgets/checkout_button.dart';
import '../widgets/order_field.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final beverages = ref.watch(beveragesProvider);
    final quantities = ref.watch(beverageQuantitiesProvider);
    final summary = _buildSummary(beverages, quantities);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left, color: Tokens.text),
        ),
        title: const Text('Your Order'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final horizontalPadding = Tokens.pApp * 2;
          final availableWidth = (width - horizontalPadding).clamp(0.0, width);
          final columns = availableWidth >= 720 ? 2 : 1;
          const spacing = 24.0;
          final fieldWidth =
              columns == 1 ? availableWidth : (availableWidth - spacing) / columns;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(Tokens.pApp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderSummaryCard(summary: summary),
                const SizedBox(height: 32),
                Wrap(
                  spacing: spacing,
                  runSpacing: 18,
                  children: [
                    for (final field in _orderFields)
                      SizedBox(
                        width: fieldWidth,
                        child: OrderField(
                          label: field.label,
                          initialValue: field.initialValue,
                          keyboardType: field.keyboardType,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 32),
                Align(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 260),
                    child: CheckoutButton(
                      onPressed: () => context.pop(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({super.key, required this.summary});

  final OrderSummary summary;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      const Text(
        'Order summary',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: Tokens.text,
        ),
      ),
      const SizedBox(height: 16),
    ];

    if (summary.lines.isEmpty) {
      children.addAll(const [
        Text(
          'No beverages selected yet.',
          style: TextStyle(color: Tokens.muted, fontSize: 14),
        ),
      ]);
    } else {
      final entries = summary.groupedLines.entries.toList();
      for (var entryIndex = 0; entryIndex < entries.length; entryIndex++) {
        final entry = entries[entryIndex];
        children.add(Text(
          entry.key,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Tokens.text,
          ),
        ));
        children.add(const SizedBox(height: 8));

        final lines = entry.value;
        for (var lineIndex = 0; lineIndex < lines.length; lineIndex++) {
          final line = lines[lineIndex];
          children.add(
            Row(
              children: [
                Text(
                  '${line.size} • ${line.quantity}x',
                  style: const TextStyle(fontSize: 12, color: Tokens.muted),
                ),
                const Spacer(),
                Text(
                  '\$${line.subtotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Tokens.text,
                  ),
                ),
              ],
            ),
          );
          if (lineIndex != lines.length - 1) {
            children.add(const SizedBox(height: 6));
          }
        }

        if (entryIndex != entries.length - 1) {
          children.add(const SizedBox(height: 12));
        }
      }

      children.addAll([
        const SizedBox(height: 12),
        const Divider(),
        const SizedBox(height: 12),
        Row(
          children: [
            const Text(
              'Total',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Tokens.text,
              ),
            ),
            const Spacer(),
            Text(
              '\$${summary.total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Tokens.text,
              ),
            ),
          ],
        ),
      ]);
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Tokens.pCard),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}

OrderSummary _buildSummary(
  List<Beverage> beverages,
  Map<String, Map<String, int>> quantities,
) {
  final lines = <OrderLine>[];
  for (final beverage in beverages) {
    final beverageQuantities = quantities[beverage.title];
    if (beverageQuantities == null) continue;
    for (final entry in beverageQuantities.entries) {
      final quantity = entry.value;
      if (quantity <= 0) continue;
      final price = beverage.prices[entry.key] ?? 0;
      lines.add(
        OrderLine(
          beverageTitle: beverage.title,
          size: entry.key,
          quantity: quantity,
          price: price,
        ),
      );
    }
  }
  return OrderSummary(lines);
}

class OrderSummary {
  OrderSummary(this.lines);

  final List<OrderLine> lines;

  Map<String, List<OrderLine>> get groupedLines {
    final map = <String, List<OrderLine>>{};
    for (final line in lines) {
      map.putIfAbsent(line.beverageTitle, () => []).add(line);
    }
    return map;
  }

  double get total =>
      lines.fold(0, (previous, line) => previous + line.subtotal);
}

class OrderLine {
  OrderLine({
    required this.beverageTitle,
    required this.size,
    required this.quantity,
    required this.price,
  });

  final String beverageTitle;
  final String size;
  final int quantity;
  final double price;

  double get subtotal => price * quantity;
}

class _OrderFieldData {
  const _OrderFieldData({
    required this.label,
    this.initialValue,
    this.keyboardType,
  });

  final String label;
  final String? initialValue;
  final TextInputType? keyboardType;
}

const _orderFields = [
  _OrderFieldData(
    label: 'First name',
    initialValue: 'Jane',
  ),
  _OrderFieldData(
    label: 'Last name',
    initialValue: 'Doe',
  ),
  _OrderFieldData(
    label: 'Email address',
    initialValue: 'jane@example.com',
    keyboardType: TextInputType.emailAddress,
  ),
  _OrderFieldData(
    label: 'Phone number (10 digits)',
    initialValue: '4161234567',
    keyboardType: TextInputType.phone,
  ),
  _OrderFieldData(
    label: 'Cardholder name',
    initialValue: 'Jane Doe',
  ),
  _OrderFieldData(
    label: 'Card number',
    initialValue: '4242 4242 4242 4242',
    keyboardType: TextInputType.number,
  ),
  _OrderFieldData(
    label: 'Expiry (MM/YY)',
    initialValue: '12/28',
  ),
  _OrderFieldData(
    label: 'CVV',
    initialValue: '123',
    keyboardType: TextInputType.number,
  ),
];
