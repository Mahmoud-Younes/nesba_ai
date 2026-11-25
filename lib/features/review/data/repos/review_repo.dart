import 'package:nesba_ai/features/review/data/models/week_summary.dart';

abstract class ReviewRepo {
  /// Full day rows — newest grouping first; each row carries
  /// name/mealType/kcal/time/groupLabel (group copy comes pre-baked).
  Future<List<Map<String, dynamic>>> todayMeals();

  /// Day totals — consumed/goal kcal + macro grams.
  Future<Map<String, dynamic>> todaySummary();

  /// Last seven days + weekly macro grams for the week view (S07).
  Future<WeekSummary> weekSummary();

  /// Swipe-delete persistence — the shared today truth drops the row so the
  /// log gate cannot resurrect it on its next read.
  void removeMeal(String id);

  /// Undo of [removeMeal] — same index, same row.
  void restoreMeal(int index, Map<String, dynamic> row);
}
