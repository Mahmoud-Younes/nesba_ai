enum MealUnit { piece, cup, gram, spoon }

class MealItem {
  const MealItem({
    required this.name,
    required this.quantityMultiplier,
    required this.unit,
    required this.kcal,
    this.grams,
    this.isLowConfidence = false,
    this.isEdited = false,
  });

  final String name;
  final double quantityMultiplier;
  final int? grams;
  final MealUnit unit;
  final int kcal;
  final bool isLowConfidence;
  final bool isEdited;

  MealItem copyWith({
    String? name,
    double? quantityMultiplier,
    int? grams,
    MealUnit? unit,
    int? kcal,
    bool? isLowConfidence,
    bool? isEdited,
  }) {
    return MealItem(
      name: name ?? this.name,
      quantityMultiplier: quantityMultiplier ?? this.quantityMultiplier,
      grams: grams ?? this.grams,
      unit: unit ?? this.unit,
      kcal: kcal ?? this.kcal,
      isLowConfidence: isLowConfidence ?? this.isLowConfidence,
      isEdited: isEdited ?? this.isEdited,
    );
  }
}
