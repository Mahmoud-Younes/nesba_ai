import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nesba_ai/features/review/data/repos/review_repo.dart';

part 'review_cubit.freezed.dart';
part 'review_state.dart';

/// Drives the review gate: day ring + macros + full meals list, and the
/// day/week switch (S06/S07, spec §2.6).
class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit(this._repo) : super(const ReviewState());

  final ReviewRepo _repo;

  // Skeleton rides the first read only — later loads swap in place.
  bool _hasLoaded = false;

  Future<void> load() async {
    final bool firstRead = !_hasLoaded;
    if (firstRead) {
      emit(state.copyWith(isLoading: true));
    }
    // Both requests start together; the 600ms mock latency overlaps.
    final Future<Map<String, dynamic>> summaryFuture = _repo.todaySummary();
    final Future<List<Map<String, dynamic>>> mealsFuture = _repo.todayMeals();
    final Map<String, dynamic> summary = await summaryFuture;
    final List<Map<String, dynamic>> meals = await mealsFuture;
    _hasLoaded = true;
    emit(state.copyWith(
      isLoading: false,
      summary: summary,
      macros: (
        protein: summary['protein'] as int? ?? 0,
        carbs: summary['carbs'] as int? ?? 0,
        fat: summary['fat'] as int? ?? 0,
      ),
      meals: meals,
    ));
  }

  /// Day/week switch; the week view itself ships with ticket #28.
  void toggleMode(ReviewMode mode) {
    if (mode == state.mode) return;
    // TODO(week-view): ticket #28 — weeklyData stays empty until the weekly
    // chart/summary land; the screen shows the week empty state meanwhile.
    emit(state.copyWith(
      mode: mode,
      weeklyData: mode == ReviewMode.week
          ? const <Map<String, dynamic>>[]
          : state.weeklyData,
    ));
  }

  // Swipe-to-delete with undo — snapshot keeps the row's original position.
  int? _removedIndex;
  Map<String, dynamic>? _removedMeal;

  void removeMeal(Map<String, dynamic> meal) {
    final int index =
        state.meals.indexWhere((Map<String, dynamic> m) => m['id'] == meal['id']);
    if (index < 0) return;
    _removedIndex = index;
    _removedMeal = meal;
    final List<Map<String, dynamic>> meals = List.of(state.meals)
      ..removeAt(index);
    emit(state.copyWith(meals: meals));
  }

  void undoRemoveMeal() {
    final int? index = _removedIndex;
    final Map<String, dynamic>? meal = _removedMeal;
    if (index == null || meal == null) return;
    final List<Map<String, dynamic>> meals = List.of(state.meals)
      ..insert(index, meal);
    _removedIndex = null;
    _removedMeal = null;
    emit(state.copyWith(meals: meals));
  }
}
