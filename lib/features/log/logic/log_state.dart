part of 'log_cubit.dart';

enum LogStatus { draft, analyzing, result, saved }

@freezed
abstract class LogState with _$LogState {
  const factory LogState({
    @Default(LogStatus.draft) LogStatus status,
    @Default('') String description,
    AnalysisResult? result,
    @Default(1) int progressStep,
    @Default(0) int elapsedSeconds,
    @Default(false) bool isStale,
    @Default(false) bool isTimeout,
    @Default(false) bool isSaving,
    @Default(false) bool isDetailsExpanded,
    @Default(false) bool showDisclaimer,
    String? savedMealId,
    @Default(<Map<String, dynamic>>[]) List<Map<String, dynamic>> todayMeals,
    @Default(2000) int goalKcal,
    @Default(0) int consumedKcal,
  }) = _LogState;
}
