/// The one vocabulary shared by the prompt, the Gemini response, the Dart
/// filter and the UI labels.
enum RestrictionCategory {
  gluten('gluten'),
  dairy('dairy'),
  eggs('eggs'),
  treeNuts('tree_nuts'),
  peanuts('peanuts'),
  sesame('sesame'),
  fish('fish'),
  shellfish('shellfish'),
  soy('soy'),
  unknown('unknown');

  const RestrictionCategory(this.wire);

  final String wire;

  bool get isKnown => this != RestrictionCategory.unknown;

  static RestrictionCategory fromWire(String? value) => values.firstWhere(
    (RestrictionCategory category) => category.wire == value,
    orElse: () => RestrictionCategory.unknown,
  );

  static const int version = 1;
}
