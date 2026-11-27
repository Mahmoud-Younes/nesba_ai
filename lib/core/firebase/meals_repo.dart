import 'package:nesba_ai/core/firebase/meal_alternatives.dart';
import 'package:nesba_ai/core/firebase/meal_row.dart';

abstract interface class MealsRepo {
  Stream<List<MealRow>> watchTodayMeals();
  Future<String> saveMeal(MealRow meal);
  Future<void> undoSave(String mealId);
  Future<void> removeMeal(String mealId);
  Future<void> restoreMeal(String mealId);
  Future<void> retryWrite(String mealId);

  /// Raw alternatives are stored with the meal and read back at display time.
  Stream<List<RawAlternative>> watchAlternatives(String mealId);
  Future<void> saveAlternatives(
    String mealId,
    List<RawAlternative> alternatives,
  );
}
