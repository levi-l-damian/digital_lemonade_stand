import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../tokens.dart';
import '../widgets/checkout_button.dart';
import '../widgets/order_field.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
