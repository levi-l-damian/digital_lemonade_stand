/// Material 3 theme wired to tokens
library;

import 'package:flutter/material.dart';
import 'tokens.dart';

ThemeData buildTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Tokens.primary,
      primary: Tokens.primary,
      surface: Tokens.surface,
      onPrimary: Tokens.text,
      onSurface: Tokens.text,
    ),
    fontFamilyFallback: Tokens.fontFamilyFallback,
  );

  return base.copyWith(
    scaffoldBackgroundColor: Tokens.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: Tokens.primary,
      foregroundColor: Tokens.text,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Tokens.text,
        fontWeight: FontWeight.w700,
        fontSize: 18,
        height: 18 / 18,
        fontFamilyFallback: Tokens.fontFamilyFallback,
      ),
      toolbarHeight: 80,
    ),
    cardTheme: CardThemeData(
      color: Tokens.card,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Tokens.rCard),
        side: const BorderSide(color: Tokens.outline, width: 1),
      ),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Tokens.card,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Tokens.rInput),
        borderSide: const BorderSide(color: Tokens.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Tokens.rInput),
        borderSide: const BorderSide(color: Tokens.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Tokens.rInput),
        borderSide: BorderSide(color: Tokens.primary, width: 1.5),
      ),
      labelStyle: TextStyle(color: Tokens.muted, fontSize: 12),
      hintStyle: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 12),
    ),

    // Checkout button (primary)
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(
          Size.fromHeight(Tokens.btnOrderHeight),
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (states) => Tokens.primaryButton,
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (states) => Tokens.text,
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Tokens.rButton),
            side: const BorderSide(color: Tokens.outline),
          ),
        ),
        textStyle: WidgetStateProperty.all(
          TextStyle(fontWeight: FontWeight.w700, fontSize: 14, height: 18 / 14),
        ),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.pressed)) {
            return Colors.black.withValues(alpha: 0.12); // pressed effect
          }
          if (states.contains(WidgetState.hovered)) {
            return Colors.black.withValues(alpha: 0.06); // hover effect
          }
          return null;
        }),
      ),
    ),
  );
}
