/// Type-scale tokens from Bustan spec §1.3 (the M3 ladder at Plex sizes).
///
/// Sizes live here so screens never spell a magic `fontSize` — they read a
/// token and pass it through `.sp`, which keeps the ladder identical in both
/// scripts (the Arabic column differs only in weight and line-height, per
/// brand §0.3, never in size).
class AppTypeScale {
  const AppTypeScale._();

  /// Hero numerals — the calorie ring and the splash wordmark.
  static const double displaySmall = 36;

  /// Page titles ("Describe your meal", "Sign in").
  static const double headlineMedium = 28;

  /// Secondary screen titles and sheet titles.
  static const double headlineSmall = 24;

  /// Section headings above a card ("Nutrition snapshot").
  static const double titleLarge = 22;

  /// Card titles and list-row leading text.
  static const double titleMedium = 16;

  /// Field labels inside a card ("Meal Description").
  static const double titleSmall = 14;

  /// Lead paragraph — the subtitle under a page title.
  static const double bodyLarge = 16;

  /// Default body copy.
  static const double bodyMedium = 14;

  /// Units, captions, footnotes, the inline disclaimer.
  static const double bodySmall = 12;

  /// Button labels.
  static const double labelLarge = 14;

  /// Chips and badges.
  static const double labelMedium = 12;

  /// Smallest label — nav bar destinations.
  static const double labelSmall = 11;

  /// Tracking for the uppercase eyebrow above a page title.
  static const double eyebrowTracking = 1.2;
}
