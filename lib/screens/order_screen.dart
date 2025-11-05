import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/beverage_providers.dart';
import '../tokens.dart';
import '../widgets/checkout_button.dart';
import '../widgets/order_field.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItems = ref.watch(selectedItemsProvider);
    final total = selectedItems.fold<double>(
      0,
      (sum, item) => sum + item.totalPrice,
    );

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
                _OrderSummary(
                  items: selectedItems,
                  total: total,
                ),
                if (selectedItems.isNotEmpty) const SizedBox(height: 24),
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
                      onPressed:
                          selectedItems.isEmpty ? null : () => context.pop(),
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

class _OrderSummary extends StatelessWidget {
  const _OrderSummary({
    required this.items,
    required this.total,
  });

  final List<BeverageSelection> items;
  final double total;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: Tokens.muted),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'No items selected yet. Please go back to add drinks.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Items',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Tokens.muted,
                  ),
            ),
            const SizedBox(height: 12),
            for (final item in items) ...[
              _OrderItemRow(item: item),
              if (item != items.last) const SizedBox(height: 8),
            ],
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  const _OrderItemRow({required this.item});

  final BeverageSelection item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            '${item.quantity} × ${item.beverageTitle} (${item.size})',
            style: theme.textTheme.bodyMedium,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          '\$${item.totalPrice.toStringAsFixed(2)}',
          style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
