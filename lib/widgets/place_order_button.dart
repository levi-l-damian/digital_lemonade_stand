import 'package:flutter/material.dart';

import '../tokens.dart';

class PlaceOrderButton extends StatelessWidget {
  const PlaceOrderButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(Tokens.btnHomeHeight),
        backgroundColor: isEnabled ? Tokens.primaryButton : Tokens.disabled,
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
      child: const Text('Place Order'),
    );
  }
}
