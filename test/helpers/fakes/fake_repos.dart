import 'dart:async';

import 'package:nesba_ai/core/firebase/auth_repo.dart';
import 'package:nesba_ai/core/firebase/goal_repo.dart';
import 'package:nesba_ai/core/firebase/goal_value.dart';
import 'package:nesba_ai/core/firebase/meal_alternatives.dart';
import 'package:nesba_ai/core/firebase/meal_row.dart';
import 'package:nesba_ai/core/firebase/meals_repo.dart';
import 'package:nesba_ai/core/firebase/profile_repo.dart';
import 'package:nesba_ai/core/firebase/user_profile.dart';

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
  final Map<String, List<RawAlternative>> _alternatives =
      <String, List<RawAlternative>>{};
  final StreamController<List<MealRow>> _controller =
      StreamController<List<MealRow>>.broadcast();
  final StreamController<List<RawAlternative>> _alternativesController =
      StreamController<List<RawAlternative>>.broadcast();

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

  @override
  Stream<List<RawAlternative>> watchAlternatives(String mealId) =>
      _alternativesController.stream;

  @override
  Future<void> saveAlternatives(
    String mealId,
    List<RawAlternative> alternatives,
  ) async {
    _alternatives[mealId] = List<RawAlternative>.from(alternatives);
    _alternativesController.add(List<RawAlternative>.from(alternatives));
  }
}

class FakeGoalRepo implements GoalRepo {
  GoalValue _goal = const GoalValue();

  @override
  Stream<GoalValue> watchGoal() => Stream<GoalValue>.value(_goal);

  @override
  Future<GoalValue> readGoal() async => _goal;

  @override
  Future<void> writeGoal(GoalValue goal) async => _goal = goal;
}

class FakeProfileRepo implements ProfileRepository {
  UserProfile _profile = const UserProfile();

  @override
  Future<UserProfile?> read() async => _profile;

  @override
  Stream<UserProfile> watch() => Stream<UserProfile>.value(_profile);

  void setProfile(UserProfile profile) => _profile = profile;
}
