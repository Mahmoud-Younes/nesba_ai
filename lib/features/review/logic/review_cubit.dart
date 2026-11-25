import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nesba_ai/core/helpers/app_logger.dart';
import 'package:nesba_ai/features/review/data/models/week_summary.dart';
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
      final Future<WeekSummary> weekFuture = _repo.weekSummary();
      final Map<String, dynamic> summary = await summaryFuture;
      final List<Map<String, dynamic>> meals = await mealsFuture;
      final WeekSummary week = await weekFuture;
      _hasLoaded = true;
      appLog('review loaded: ${meals.length} meals, ${week.days.length} days');
      emit(state.copyWith(
        isLoading: false,
        errorMessage: null,
        summary: summary,
        week: week,
        macros: (
          protein: (summary['protein'] as num? ?? 0).toInt(),
          carbs: (summary['carbs'] as num? ?? 0).toInt(),
          fat: (summary['fat'] as num? ?? 0).toInt(),
        ),
        meals: meals,
      ));
    } on Exception catch (error) {
      // states §1.5 review-day: error card + retry, previous cache stays.
      AppLogger.error('review load failed', error);
      emit(state.copyWith(isLoading: false, errorMessage: 'server'));
    }
  }

  /// Day/week switch — both readings come from the same load.
  void toggleMode(ReviewMode mode) {
    if (mode == state.mode) return;
    appLog('review mode -> ${mode.name}');
    emit(state.copyWith(mode: mode));
  }

  // Swipe-to-delete with undo — the whole pre-removal list is snapshotted so
  // the latest delete only is undoable, and it restores exactly what was.
  // The mock source is mutated too, so the log gate never resurrects the row.
  List<Map<String, dynamic>>? _mealsBeforeRemoval;
  int? _removedIndex;

  void removeMeal(Map<String, dynamic> meal) {
    final int index =
        state.meals.indexWhere((Map<String, dynamic> m) => m['id'] == meal['id']);
    if (index < 0) return;
    _mealsBeforeRemoval = List.of(state.meals);
    _removedIndex = index;
    final List<Map<String, dynamic>> meals = List.of(state.meals)
      ..removeAt(index);
    _repo.removeMeal(meal['id'] as String? ?? '');
    emit(_withMeals(state, meals));
  }

  void undoRemoveMeal() {
    final List<Map<String, dynamic>>? snapshot = _mealsBeforeRemoval;
    if (snapshot == null) return;
    final int index = _removedIndex ?? 0;
    _mealsBeforeRemoval = null;
    _removedIndex = null;
    _repo.restoreMeal(index, snapshot[index]);
    emit(_withMeals(state, snapshot));
  }

  // Deletes move the day total with the list — ring, status row and today's
  // chart bar stay on the same truth as the rows (§3.1).
  ReviewState _withMeals(
    ReviewState base,
    List<Map<String, dynamic>> meals,
  ) {
    final int consumed = meals.fold<int>(
      0,
      (int sum, Map<String, dynamic> row) =>
          sum + ((row['kcal'] as num? ?? 0).toInt()),
    );
    final Map<String, dynamic>? summary = base.summary == null
        ? null
        : (Map<String, dynamic>.of(base.summary!)..['consumed'] = consumed);
    final WeekSummary? week = base.week;
    WeekSummary? nextWeek;
    if (week != null && week.days.isNotEmpty) {
      final List<WeekDay> days = List.of(week.days);
      days[days.length - 1] =
          WeekDay(date: days.last.date, kcal: consumed);
      nextWeek = WeekSummary(
        days: days,
        proteinGrams: week.proteinGrams,
        carbsGrams: week.carbsGrams,
        fatGrams: week.fatGrams,
      );
    }
    return base.copyWith(meals: meals, summary: summary, week: nextWeek);
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
