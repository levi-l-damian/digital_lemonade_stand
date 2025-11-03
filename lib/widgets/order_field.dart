import 'package:flutter/material.dart';

import '../tokens.dart';

class OrderField extends StatelessWidget {
  const OrderField({
    super.key,
    required this.label,
    this.hint,
    this.initialValue,
    this.keyboardType,
  });

  final String label;
  final String? hint;
  final String? initialValue;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
      style: const TextStyle(
        fontSize: 14,
        color: Tokens.text,
      ),
    );
  }
}
