import 'package:flutter/material.dart';
import 'package:nesba_ai/core/style/colors/colors_dark.dart';
import 'package:nesba_ai/core/style/colors/colors_light.dart';
import 'package:nesba_ai/core/style/fonts/font_family_helper.dart';
import 'package:nesba_ai/core/style/theme/app_radius.dart';
import 'package:nesba_ai/core/style/theme/color_extension.dart';

// Bustan theme wiring (design/brand-directions.md §1.2 + §1.4).

ThemeData themeDark() {
  final ColorScheme scheme = const ColorScheme.dark(
    brightness: Brightness.dark,
    primary: ColorsDark.primary,
    onPrimary: ColorsDark.onPrimary,
    primaryContainer: ColorsDark.primaryContainer,
    onPrimaryContainer: ColorsDark.onPrimaryContainer,
    secondary: ColorsDark.secondary,
    onSecondary: ColorsDark.onSecondary,
    secondaryContainer: ColorsDark.secondaryContainer,
    onSecondaryContainer: ColorsDark.onSecondaryContainer,
    tertiary: ColorsDark.tertiary,
    onTertiary: ColorsDark.onTertiary,
    tertiaryContainer: ColorsDark.tertiaryContainer,
    onTertiaryContainer: ColorsDark.onTertiaryContainer,
    error: ColorsDark.error,
    onError: ColorsDark.onError,
    errorContainer: ColorsDark.errorContainer,
    onErrorContainer: ColorsDark.onErrorContainer,
    surface: ColorsDark.surface,
    onSurface: ColorsDark.onSurface,
    surfaceDim: ColorsDark.surfaceDim,
    surfaceBright: ColorsDark.surfaceBright,
    surfaceContainerLowest: ColorsDark.surfaceContainerLowest,
    surfaceContainerLow: ColorsDark.surfaceContainerLow,
    surfaceContainer: ColorsDark.surfaceContainer,
    surfaceContainerHigh: ColorsDark.surfaceContainerHigh,
    surfaceContainerHighest: ColorsDark.surfaceContainerHighest,
    onSurfaceVariant: ColorsDark.onSurfaceVariant,
    outline: ColorsDark.outline,
    outlineVariant: ColorsDark.outlineVariant,
    inverseSurface: ColorsDark.inverseSurface,
    onInverseSurface: ColorsDark.inverseOnSurface,
    inversePrimary: ColorsDark.inversePrimary,
    surfaceTint: ColorsDark.surfaceTint,
    scrim: ColorsDark.scrim,
    shadow: ColorsDark.shadow,
  );
  return _bustanTheme(scheme, const <ThemeExtension<dynamic>>[MyColors.dark]);
}

ThemeData themeLight() {
  final ColorScheme scheme = const ColorScheme.light(
    brightness: Brightness.light,
    primary: ColorsLight.primary,
    onPrimary: ColorsLight.onPrimary,
    primaryContainer: ColorsLight.primaryContainer,
    onPrimaryContainer: ColorsLight.onPrimaryContainer,
    secondary: ColorsLight.secondary,
    onSecondary: ColorsLight.onSecondary,
    secondaryContainer: ColorsLight.secondaryContainer,
    onSecondaryContainer: ColorsLight.onSecondaryContainer,
    tertiary: ColorsLight.tertiary,
    onTertiary: ColorsLight.onTertiary,
    tertiaryContainer: ColorsLight.tertiaryContainer,
    onTertiaryContainer: ColorsLight.onTertiaryContainer,
    error: ColorsLight.error,
    onError: ColorsLight.onError,
    errorContainer: ColorsLight.errorContainer,
    onErrorContainer: ColorsLight.onErrorContainer,
    surface: ColorsLight.surface,
    onSurface: ColorsLight.onSurface,
    surfaceDim: ColorsLight.surfaceDim,
    surfaceBright: ColorsLight.surfaceBright,
    surfaceContainerLowest: ColorsLight.surfaceContainerLowest,
    surfaceContainerLow: ColorsLight.surfaceContainerLow,
    surfaceContainer: ColorsLight.surfaceContainer,
    surfaceContainerHigh: ColorsLight.surfaceContainerHigh,
    surfaceContainerHighest: ColorsLight.surfaceContainerHighest,
    onSurfaceVariant: ColorsLight.onSurfaceVariant,
    outline: ColorsLight.outline,
    outlineVariant: ColorsLight.outlineVariant,
    inverseSurface: ColorsLight.inverseSurface,
    onInverseSurface: ColorsLight.inverseOnSurface,
    inversePrimary: ColorsLight.inversePrimary,
    surfaceTint: ColorsLight.surfaceTint,
    scrim: ColorsLight.scrim,
    shadow: ColorsLight.shadow,
  );
  return _bustanTheme(scheme, const <ThemeExtension<dynamic>>[MyColors.light]);
}

ThemeData _bustanTheme(
  ColorScheme scheme,
  List<ThemeExtension<dynamic>> extensions,
) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,
    extensions: extensions,
    textTheme: TextTheme(
      // Base style — widgets use context.textStyle.copyWith(...) (asroo_store way).
      displaySmall: TextStyle(
        fontSize: 14,
        color: scheme.onSurface,
        fontFamily: FontFamilyHelper.geLocalozedFontFamily(),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(style: _bustanButtonStyle()),
    outlinedButtonTheme: OutlinedButtonThemeData(style: _bustanButtonStyle()),
    elevatedButtonTheme: ElevatedButtonThemeData(style: _bustanButtonStyle()),
    inputDecorationTheme: _bustanInputTheme(scheme),
    cardTheme: _bustanCardTheme(),
    bottomSheetTheme: _bustanBottomSheetTheme(),
    snackBarTheme: _bustanSnackBarTheme(scheme),
  );
}

// Buttons: stadium shape, min height 48dp (brand §1.4).
ButtonStyle _bustanButtonStyle() {
  return ButtonStyle(
    shape: const WidgetStatePropertyAll<OutlinedBorder>(StadiumBorder()),
    minimumSize: const WidgetStatePropertyAll<Size>(Size(64, 48)),
  );
}

// Text inputs: outlined, corner 8, focus border primary at width 2.
InputDecorationThemeData _bustanInputTheme(ColorScheme scheme) {
  final BorderRadius radius = BorderRadius.circular(AppRadius.small);
  return InputDecorationThemeData(
    border: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: scheme.outline),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: scheme.outline),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: scheme.primary, width: 2),
    ),
  );
}

// Cards: corner 12, elevation 0 (tint-first — depth in surfaceContainer ramp).
CardThemeData _bustanCardTheme() {
  return const CardThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppRadius.medium)),
    ),
    elevation: 0,
  );
}

// Bottom sheets: top corners 16.
BottomSheetThemeData _bustanBottomSheetTheme() {
  return const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.large)),
    ),
  );
}

// Snackbars invert the surface.
SnackBarThemeData _bustanSnackBarTheme(ColorScheme scheme) {
  return SnackBarThemeData(
    backgroundColor: scheme.inverseSurface,
    contentTextStyle: TextStyle(
      color: scheme.onInverseSurface,
      fontFamily: FontFamilyHelper.geLocalozedFontFamily(),
    ),
  );
}
