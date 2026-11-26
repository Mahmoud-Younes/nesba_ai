import 'dart:async';

import 'package:nesba_ai/core/firebase/auth_repo.dart';
import 'package:nesba_ai/core/firebase/goal_repo.dart';
import 'package:nesba_ai/core/firebase/meal_row.dart';
import 'package:nesba_ai/core/firebase/meals_repo.dart';

/// Test doubles for the shared contracts. Firebase is never initialized in
/// unit or widget tests.
class FakeAuthRepo implements AuthRepo {
  String? uid;

  @override
  Future<String> signInWithEmail(String email, String password) async =>
      uid = 'test-uid';

  @override
  Future<String> signInWithGoogle() async => uid = 'test-uid';

  @override
  Future<void> signOut() async => uid = null;
}

class FakeMealsRepo implements MealsRepo {
  final List<MealRow> rows = <MealRow>[];
  final StreamController<List<MealRow>> _controller =
      StreamController<List<MealRow>>.broadcast();

  @override
  Stream<List<MealRow>> watchTodayMeals() => _controller.stream;

  @override
  Future<String> saveMeal(MealRow meal) async {
    rows.add(meal);
    _controller.add(List<MealRow>.from(rows));
    return meal.id;
  }

  @override
  Future<void> undoSave(String mealId) async {
    rows.removeWhere((MealRow row) => row.id == mealId);
    _controller.add(List<MealRow>.from(rows));
  }

  @override
  Future<void> removeMeal(String mealId) async {
    rows.removeWhere((MealRow row) => row.id == mealId);
    _controller.add(List<MealRow>.from(rows));
  }

  @override
  Future<void> restoreMeal(String mealId) async {
    _controller.add(List<MealRow>.from(rows));
  }

  @override
  Future<void> retryWrite(String mealId) async {
    _controller.add(List<MealRow>.from(rows));
  }
}

class FakeGoalRepo implements GoalRepo {
  int _goal = 0;

  @override
  Stream<int> watchGoal() => Stream<int>.value(_goal);

  @override
  Future<int> readGoal() async => _goal;

  @override
  Future<void> writeGoal(int kcal) async => _goal = kcal;
}
