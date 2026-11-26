import 'package:nesba_ai/core/firebase/auth_repo.dart';
import 'package:nesba_ai/core/firebase/goal_repo.dart';
import 'package:nesba_ai/core/firebase/meal_row.dart';
import 'package:nesba_ai/core/firebase/meals_repo.dart';

/// Placeholders keep the dependency graph complete until the four feature
/// tracks land their real implementations and the final binding commit wires
/// them in. No production feature calls these yet.
class PendingAuthRepo implements AuthRepo {
  @override
  Future<String> signInWithEmail(String email, String password) =>
      throw UnimplementedError('auth track');

  @override
  Future<String> signInWithGoogle() => throw UnimplementedError('auth track');

  @override
  Future<void> signOut() => throw UnimplementedError('auth track');
}

class PendingMealsRepo implements MealsRepo {
  @override
  Stream<List<MealRow>> watchTodayMeals() =>
      throw UnimplementedError('meals track');

  @override
  Future<String> saveMeal(MealRow meal) =>
      throw UnimplementedError('meals track');

  @override
  Future<void> undoSave(String mealId) =>
      throw UnimplementedError('meals track');

  @override
  Future<void> removeMeal(String mealId) =>
      throw UnimplementedError('meals track');

  @override
  Future<void> restoreMeal(String mealId) =>
      throw UnimplementedError('meals track');

  @override
  Future<void> retryWrite(String mealId) =>
      throw UnimplementedError('meals track');
}

class PendingGoalRepo implements GoalRepo {
  @override
  Stream<int> watchGoal() => throw UnimplementedError('goal track');

  @override
  Future<int> readGoal() => throw UnimplementedError('goal track');

  @override
  Future<void> writeGoal(int kcal) => throw UnimplementedError('goal track');
}
