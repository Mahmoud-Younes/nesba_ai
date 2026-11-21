import 'package:nesba_ai/core/service/shared_pref/pref_keys.dart';
import 'package:nesba_ai/core/service/shared_pref/shared_pref.dart';

/// Single mock "today" truth behind the log and review repos — the strip
/// and the hero read the same day (ticket 21 follow-up; spec §3.1 wants
/// راجع fed by a stream of this data). The real data layer replaces this
/// with the backend stream.
class MockTodayDataSource {
  MockTodayDataSource._();

  static final MockTodayDataSource instance = MockTodayDataSource._();

  final List<Map<String, dynamic>> _meals = _seed();

  static List<Map<String, dynamic>> _seed() => <Map<String, dynamic>>[
        <String, dynamic>{
          'id': 'mock_meal_101',
          'name': 'شوفان بالحليب والموز',
          'type': 'breakfast',
          'kcal': 380,
          'time': '07:40',
          'sync': 'ok',
          'groupKey': 'today',
        },
        <String, dynamic>{
          'id': 'mock_meal_102',
          'name': 'قهوة بالحليب',
          'type': 'snack',
          'kcal': 90,
          'time': '10:15',
          'sync': 'pending',
          'groupKey': 'today',
        },
        <String, dynamic>{
          'id': 'mock_meal_103',
          'name': 'صدر دجاج مشوي مع أرز',
          'type': 'lunch',
          'kcal': 620,
          'time': '13:30',
          'sync': 'ok',
          'groupKey': 'today',
        },
        <String, dynamic>{
          'id': 'mock_meal_104',
          'name': 'سلطة خضراء بالفيتا',
          'type': 'dinner',
          'kcal': 150,
          'time': '20:10',
          'sync': 'failed',
          'groupKey': 'yesterday',
        },
      ];

  /// CD-06: the goal exists only after the user sets it — 0 until then.
  int get goalKcal {
    try {
      return int.tryParse(
            SharedPref().getString(PrefKeys.dailyGoalKcal) ?? '',
          ) ??
          0;
    } catch (_) {
      return 0;
    }
  }

  int get consumedKcal => _meals.fold(
        0,
        (int sum, Map<String, dynamic> row) =>
            sum + ((row['kcal'] as num? ?? 0).toInt()),
      );

  List<Map<String, dynamic>> todayMeals() => List.of(_meals);

  void addMeal(Map<String, dynamic> row) => _meals.insert(0, row);

  void removeMeal(String mealId) => _meals.removeWhere(
        (Map<String, dynamic> row) => row['id'] == mealId,
      );

  /// Test isolation — restores the seed rows.
  void reset() {
    _meals
      ..clear()
      ..addAll(_seed());
  }
}
