part of 'review_cubit.dart';

/// day/week surface of the review gate (spec §2.6/§2.7).
enum ReviewMode { day, week }

@freezed
abstract class ReviewState with _$ReviewState {
  const factory ReviewState({
    @Default(ReviewMode.day) ReviewMode mode,
    @Default(false) bool isLoading,
    // TODO(review-data): first-run flag needs a real history source — the
    // mock keeps it false so the seeded meals show the list branch.
    @Default(false) bool isFirstRun,
    @Default(<Map<String, dynamic>>[]) List<Map<String, dynamic>> meals,
    Map<String, dynamic>? summary,

    /// Grams per macro for the day grid — null until the summary lands.
    ({int protein, int carbs, int fat})? macros,
    @Default(<Map<String, dynamic>>[]) List<Map<String, dynamic>> weeklyData,
  }) = _ReviewState;
}
