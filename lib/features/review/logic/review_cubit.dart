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
    try {
      // Both requests start together; the 600ms mock latency overlaps.
      final Future<Map<String, dynamic>> summaryFuture = _repo.todaySummary();
      final Future<List<Map<String, dynamic>>> mealsFuture = _repo.todayMeals();
      final Map<String, dynamic> summary = await summaryFuture;
      final List<Map<String, dynamic>> meals = await mealsFuture;
      _hasLoaded = true;
      emit(state.copyWith(
        isLoading: false,
        errorMessage: null,
        summary: summary,
        macros: (
          protein: (summary['protein'] as num? ?? 0).toInt(),
          carbs: (summary['carbs'] as num? ?? 0).toInt(),
          fat: (summary['fat'] as num? ?? 0).toInt(),
        ),
        meals: meals,
      ));
    } on Exception {
      // states §1.5 review-day: error card + retry, previous cache stays.
      emit(state.copyWith(isLoading: false, errorMessage: 'server'));
    }
  }

  /// Day/week switch; the week view itself ships with ticket #28.
  void toggleMode(ReviewMode mode) {
    if (mode == state.mode) return;
    emit(state.copyWith(mode: mode));
  }

  // Swipe-to-delete with undo — the whole pre-removal list is snapshotted so
  // the latest delete only is undoable, and it restores exactly what was.
  List<Map<String, dynamic>>? _mealsBeforeRemoval;

  void removeMeal(Map<String, dynamic> meal) {
    final int index =
        state.meals.indexWhere((Map<String, dynamic> m) => m['id'] == meal['id']);
    if (index < 0) return;
    _mealsBeforeRemoval = List.of(state.meals);
    final List<Map<String, dynamic>> meals = List.of(state.meals)
      ..removeAt(index);
    emit(state.copyWith(meals: meals));
  }

  void undoRemoveMeal() {
    final List<Map<String, dynamic>>? snapshot = _mealsBeforeRemoval;
    if (snapshot == null) return;
    _mealsBeforeRemoval = null;
    emit(state.copyWith(meals: snapshot));
  }

  /// Failed-row swipe/badge retry (states §1.5): pending, then ok on the mock.
  Future<void> retrySync(Map<String, dynamic> meal) async {
    final String id = meal['id'] as String? ?? '';
    final int index =
        state.meals.indexWhere((Map<String, dynamic> m) => m['id'] == id);
    if (index < 0 || state.meals[index]['sync'] != 'failed') return;
    _patchRow(id, sync: 'pending');
    await Future<void>.delayed(const Duration(milliseconds: 800));
    _patchRow(id, sync: 'ok');
  }

  void _patchRow(String id, {required String sync}) {
    final List<Map<String, dynamic>> meals = List.of(state.meals);
    final int index =
        meals.indexWhere((Map<String, dynamic> m) => m['id'] == id);
    if (index < 0) return;
    meals[index] = Map<String, dynamic>.of(meals[index])..['sync'] = sync;
    emit(state.copyWith(meals: meals));
  }
}
