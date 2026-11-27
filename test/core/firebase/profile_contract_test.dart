import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/core/firebase/goal_cache_key.dart';
import 'package:nesba_ai/core/firebase/goal_state.dart';
import 'package:nesba_ai/core/firebase/goal_value.dart';
import 'package:nesba_ai/core/firebase/meal_alternatives.dart';
import 'package:nesba_ai/core/firebase/restriction_category.dart';
import 'package:nesba_ai/core/firebase/user_profile.dart';

void main() {
  group('GoalValue', () {
    test('a missing goal is unset', () {
      final GoalValue goal = GoalValue.fromMap(<String, dynamic>{});
      expect(goal.isUnset, isTrue);
      expect(goalStateOf(goal), GoalState.unset);
    });

    test('a zero goal is unset even when it has a source', () {
      final GoalValue goal = GoalValue.fromMap(<String, dynamic>{
        'dailyGoalKcal': 0,
        'goalSource': 'calculated',
      });
      expect(goal.isUnset, isTrue);
      expect(goalStateOf(goal), GoalState.unset);
    });

    test('a goal without a source is unset', () {
      final GoalValue goal = GoalValue.fromMap(<String, dynamic>{
        'dailyGoalKcal': 1800,
      });
      expect(goal.isUnset, isTrue);
      expect(goalStateOf(goal), GoalState.unset);
    });

    test('manual and calculated values are distinguished', () {
      final GoalValue manual = GoalValue.fromMap(<String, dynamic>{
        'dailyGoalKcal': 1900,
        'goalSource': 'manual',
      });
      final GoalValue calculated = GoalValue.fromMap(<String, dynamic>{
        'dailyGoalKcal': 2100,
        'goalSource': 'calculated',
      });
      expect(goalStateOf(manual), GoalState.manual);
      expect(goalStateOf(calculated), GoalState.calculated);
    });
  });

  group('UserProfile', () {
    test('parses a partial document and ignores unknown keys', () {
      final UserProfile profile = UserProfile.fromMap(<String, dynamic>{
        'weightKg': 70.5,
        'futureField': 'ignored',
      });
      expect(profile.weightKg, 70.5);
      expect(profile.heightCm, isNull);
      expect(profile.restrictions, isEmpty);
      expect(profile.preferenceText, '');
    });

    test('drops unknown restriction values', () {
      final UserProfile profile = UserProfile.fromMap(<String, dynamic>{
        'restrictions': <String>['peanuts', 'not_a_category'],
      });
      expect(profile.restrictions, <RestrictionCategory>[
        RestrictionCategory.peanuts,
      ]);
    });

    test('toMap uses the shared field names', () {
      final Map<String, dynamic> data = const UserProfile(weightKg: 80).toMap();
      expect(data.containsKey('weightKg'), isTrue);
      expect(data.containsKey('schemaVersion'), isTrue);
    });
  });

  group('alternatives', () {
    test('an empty contains list survives a round trip', () {
      final RawAlternative original = RawAlternative(
        name: 'Rice',
        type: 'lunch',
        kcal: 500,
        contains: const <RestrictionCategory>[],
      );
      final RawAlternative parsed = RawAlternative.fromMap(original.toMap());
      expect(parsed.contains, isEmpty);
      expect(parsed.kcal, 500);
    });

    test('known categories survive a round trip', () {
      final RawAlternative original = RawAlternative(
        name: 'Peanut salad',
        type: 'lunch',
        kcal: 400,
        contains: const <RestrictionCategory>[
          RestrictionCategory.peanuts,
          RestrictionCategory.gluten,
        ],
      );
      expect(
        RawAlternative.fromMap(original.toMap()).contains,
        original.contains,
      );
    });
  });

  test('the goal cache key is scoped by uid', () {
    expect(goalCacheKey('user-a') != goalCacheKey('user-b'), isTrue);
    expect(goalCacheKey('user-a').contains('user-a'), isTrue);
  });
}
