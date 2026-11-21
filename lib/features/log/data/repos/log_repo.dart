import 'package:nesba_ai/features/log/data/models/analysis_result.dart';

abstract class LogRepo {
  Future<AnalysisResult> analyzeMeal(String description);
  Future<String> saveMeal(AnalysisResult result);
  Future<void> undoSave(String mealId);
  Future<List<Map<String, dynamic>>> todayMeals();

  /// The user's daily goal (0 until set — CD-06).
  Future<int> todayGoal();
}
