import 'package:nesba_ai/features/home/data/mock_today_data_source.dart';
import 'package:nesba_ai/features/review/data/repos/review_repo.dart';

/// Mock review data — 600ms latency keeps the first-read skeleton honest.
/// Meals and the summary read the shared today truth so review can never
/// disagree with the log strip.
class MockReviewRepo implements ReviewRepo {
  static const Duration _latency = Duration(milliseconds: 600);

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
}
