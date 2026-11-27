import 'package:nesba_ai/core/firebase/auth_repo.dart';
import 'package:nesba_ai/core/firebase/goal_repo.dart';
import 'package:nesba_ai/core/firebase/goal_value.dart';
import 'package:nesba_ai/core/firebase/meal_alternatives.dart';
import 'package:nesba_ai/core/firebase/meal_row.dart';
import 'package:nesba_ai/core/firebase/meals_repo.dart';
import 'package:nesba_ai/core/firebase/profile_repo.dart';
import 'package:nesba_ai/core/firebase/user_profile.dart';

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

  @override
  Stream<List<RawAlternative>> watchAlternatives(String mealId) =>
      throw UnimplementedError('meals track');

  @override
  Future<void> saveAlternatives(
    String mealId,
    List<RawAlternative> alternatives,
  ) => throw UnimplementedError('meals track');
}

class PendingGoalRepo implements GoalRepo {
  @override
  Stream<GoalValue> watchGoal() => throw UnimplementedError('goal track');

  @override
  Future<GoalValue> readGoal() => throw UnimplementedError('goal track');

  @override
  Future<void> writeGoal(GoalValue goal) =>
      throw UnimplementedError('goal track');
}

class PendingProfileRepo implements ProfileRepository {
  @override
  Future<UserProfile?> read() => throw UnimplementedError('auth track');

  @override
  Stream<UserProfile> watch() => throw UnimplementedError('auth track');
}
