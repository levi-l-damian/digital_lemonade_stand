import 'package:flutter/material.dart';

/// Design tokens for Digital Lemonade Stand
class Tokens {
  // Colors
  static const primary = Color(0xFFF7D14C);        // App bar / Checkout button
  static const primaryButton = Color(0xFFF7D14C);  // Checkout
  static const disabled = Color(0xFFFFF59D);       // Home "Place Order" default
  static const surface = Color(0xFFFFFCEF);        // App background
  static const card = Color(0xFFFFFFFF);
  static const outline = Color(0xFFE0E0E0);
  static const text = Color(0xFF333333);
  static const muted = Color(0xFF555555);
  static const imgPlaceholder = Color(0xFFEEEFE8);
  static const danger = Color(0xFFE53935);

  // Typography (system-ui stack)
  // In Flutter, we pick a close cross-platform family & sizes
  static const fontFamilyFallback = [
    'Inter', 'Segoe UI', 'Roboto', 'Arial'
  ];

  // Spacing & radii
  static const space = 8.0;     // base 8px
  static const rCard = 16.0;
  static const rImage = 10.0;
  static const rButton = 12.0;
  static const rInput = 10.0;
  static const pCard = 12.0;
  static const pApp = 16.0;

  // Sizes
  static const btnHomeHeight = 60.0;   // Place Order (disabled default)
  static const btnOrderHeight = 56.0;  // Checkout (primary)
}

