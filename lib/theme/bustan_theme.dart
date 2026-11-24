import 'package:flutter/material.dart';

abstract final class BustanTheme {
  static const seed = Color(0xFF2E7D32);
  static const primary = Color(0xFF38693C);
  static const primaryContainer = Color(0xFFBAF2BB);
  static const secondary = Color(0xFF52634F);
  static const secondaryContainer = Color(0xFFD5E8CF);
  static const tertiary = Color(0xFF8C4A21);
  static const tertiaryContainer = Color(0xFFFFDCC3);
  static const surface = Color(0xFFF7FBF2);
  static const surfaceContainer = Color(0xFFEBEFE6);
  static const onSurface = Color(0xFF191D17);
  static const onSurfaceVariant = Color(0xFF424940);
  static const outline = Color(0xFF727F6F);
  static const outlineVariant = Color(0xFFC2CDBD);
  static const error = Color(0xFFBA1A1A);

  static ThemeData light() {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
        ).copyWith(
          primary: primary,
          onPrimary: Colors.white,
          primaryContainer: primaryContainer,
          onPrimaryContainer: const Color(0xFF002204),
          secondary: secondary,
          onSecondary: Colors.white,
          secondaryContainer: secondaryContainer,
          onSecondaryContainer: const Color(0xFF10210F),
          tertiary: tertiary,
          tertiaryContainer: tertiaryContainer,
          onTertiaryContainer: const Color(0xFF331205),
          error: error,
          errorContainer: const Color(0xFFFFDAD6),
          onErrorContainer: const Color(0xFF410002),
          surface: surface,
          onSurface: onSurface,
          surfaceContainerLowest: Colors.white,
          surfaceContainerLow: const Color(0xFFF1F5EC),
          surfaceContainer: surfaceContainer,
          surfaceContainerHigh: const Color(0xFFE5EAE0),
          surfaceContainerHighest: const Color(0xFFE0E4DB),
          onSurfaceVariant: onSurfaceVariant,
          outline: outline,
          outlineVariant: outlineVariant,
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: 'IBMPlexSans',
      fontFamilyFallback: const ['IBMPlexSansArabic'],
      scaffoldBackgroundColor: surface,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: error, width: 2),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 48),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(48, 48),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
