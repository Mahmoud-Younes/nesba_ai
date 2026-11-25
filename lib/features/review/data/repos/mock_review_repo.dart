import 'package:nesba_ai/features/home/data/mock_today_data_source.dart';
import 'package:nesba_ai/features/review/data/models/week_summary.dart';
import 'package:nesba_ai/features/review/data/repos/review_repo.dart';

/// Mock review data — 600ms latency keeps the first-read skeleton honest.
/// Meals and the summary read the shared today truth so review can never
/// disagree with the log strip.
class MockReviewRepo implements ReviewRepo {
  static const Duration _latency = Duration(milliseconds: 600);

  // Six closed days, oldest first; null keeps one day honestly blank.
  static const List<int?> _history = <int?>[null, 1320, 1100, 2140, 1650, 1510];

  @override
  Future<List<Map<String, dynamic>>> todayMeals() async {
    await Future.delayed(_latency);
    return MockTodayDataSource.instance.todayMeals();
  }

  @override
  Future<Map<String, dynamic>> todaySummary() async {
    await Future.delayed(_latency);
    final MockTodayDataSource source = MockTodayDataSource.instance;
    return <String, dynamic>{
      'consumed': source.consumedKcal,
      'goal': source.goalKcal,
      // Macro grams + daily targets — canned demo values until the
      // analysis engine feeds real ones (declared mock).
      'protein': 78,
      'carbs': 120,
      'fat': 64,
      'proteinGoal': 120,
      'carbsGoal': 260,
      'fatGoal': 70,
    };
  }

  @override
  void removeMeal(String id) => MockTodayDataSource.instance.removeMeal(id);

  @override
  void restoreMeal(int index, Map<String, dynamic> row) =>
      MockTodayDataSource.instance.insertMeal(index, row);

  @override
  Future<WeekSummary> weekSummary() async {
    await Future.delayed(_latency);
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final List<WeekDay> days = <WeekDay>[
      for (int i = 0; i < _history.length; i++)
        WeekDay(
          date: today.subtract(Duration(days: _history.length - i)),
          kcal: _history[i],
        ),
      WeekDay(date: today, kcal: MockTodayDataSource.instance.consumedKcal),
    ];
    return WeekSummary(
      days: days,
      // Weekly grams — demo values until the engine supplies them.
      proteinGrams: 520,
      carbsGrams: 840,
      fatGrams: 400,
    );
  }
}
