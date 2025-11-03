import 'package:flutter/material.dart';

import '../tokens.dart';

class BeverageCard extends StatelessWidget {
  const BeverageCard({
    super.key,
    required this.title,
    required this.prices,
    required this.quantities,
    required this.onQuantityChanged,
    required this.onReset,
  });

  final String title;
  final Map<String, double> prices;
  final Map<String, int> quantities;
  final void Function(String size, int quantity) onQuantityChanged;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Tokens.pCard),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ImagePlaceholder(),
            const SizedBox(width: 24),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Tokens.text,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...prices.entries.map(
                        (entry) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _PriceRow(
                            size: entry.key,
                            price: entry.value,
                            quantity: quantities[entry.key] ?? 0,
                            onChanged: (value) =>
                                onQuantityChanged(entry.key, value),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    child: InkWell(
                      onTap: onReset,
                      borderRadius: BorderRadius.circular(16),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          'X',
                          style: TextStyle(
                            color: Tokens.danger,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 140,
      decoration: BoxDecoration(
        color: Tokens.imgPlaceholder,
        borderRadius: BorderRadius.circular(Tokens.rImage),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.size,
    required this.price,
    required this.quantity,
    required this.onChanged,
  });

  final String size;
  final double price;
  final int quantity;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$size \$${price.toStringAsFixed(2)}',
          style: const TextStyle(
            color: Tokens.muted,
            fontSize: 12,
          ),
        ),
        const Spacer(),
        _QuantityButton(
          icon: Icons.keyboard_arrow_up,
          onPressed: () => onChanged(quantity + 1),
        ),
        Container(
          width: 32,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Tokens.outline),
          ),
          child: Text(
            '$quantity',
            style: const TextStyle(
              fontSize: 12,
              color: Tokens.text,
            ),
          ),
        ),
        _QuantityButton(
          icon: Icons.keyboard_arrow_down,
          onPressed: () {
            if (quantity > 0) {
              onChanged(quantity - 1);
            }
          },
        ),
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: Tokens.text),
      iconSize: 18,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(width: 32, height: 32),
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
    );
  }
}
