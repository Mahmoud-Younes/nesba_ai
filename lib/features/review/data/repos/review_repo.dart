abstract class ReviewRepo {
  /// Full day rows — newest grouping first; each row carries
  /// name/mealType/kcal/time/groupLabel (group copy comes pre-baked).
  Future<List<Map<String, dynamic>>> todayMeals();

  /// Day totals — consumed/goal kcal + macro grams.
  Future<Map<String, dynamic>> todaySummary();
}
