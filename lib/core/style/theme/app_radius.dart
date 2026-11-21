/// Shape (corner radius) tokens from Bustan spec §1.4.
class AppRadius {
  const AppRadius._();

  /// Small chips and sync badges.
  static const double extraSmall = 4;

  /// Text input fields.
  static const double small = 8;

  /// Cards (literal continuity with `08` §8.5.3).
  static const double medium = 12;

  /// Bottom sheets and dialogs.
  static const double large = 16;

  /// Hero results screen.
  static const double extraLarge = 28;

  /// Buttons and FAB — stadium (full) shape, M3 default.
  static const double stadium = double.infinity;
}
