import 'package:flutter/material.dart';

import '../tokens.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(Tokens.btnOrderHeight),
        backgroundColor: Tokens.primaryButton,
        foregroundColor: Tokens.text,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Tokens.rButton),
          side: const BorderSide(color: Tokens.outline),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
      child: const Text('Checkout'),
    );
  }
}
