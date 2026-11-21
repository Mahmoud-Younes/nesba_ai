import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nesba_ai/features/log/data/models/analysis_result.dart';
import 'package:nesba_ai/features/log/data/models/meal_item.dart';
import 'package:nesba_ai/features/log/data/repos/log_repo.dart';

part 'log_cubit.freezed.dart';
part 'log_state.dart';

/// Drives the log gate: analysis timing, stale guard, save/undo and ledger.
class LogCubit extends Cubit<LogState> {
  LogCubit(this._repo) : super(const LogState());

  final LogRepo _repo;

  static const Duration _step2After = Duration(seconds: 3);
  static const Duration _step3After = Duration(seconds: 8);
  static const Duration _timeoutAfter = Duration(seconds: 45);

  Timer? _ticker;
  Stopwatch? _stopwatch;
  String _analyzedText = '';
  int _requestId = 0;
  bool _inFlight = false;

  // Snapshot for the item-delete undo window (§2.4 — G-09 snackbar).
  MealItem? _removedItem;
  int? _removedIndex;

  // Deck §2.8: the inline disclaimer rides the first result only.
  bool _disclaimerShown = false;

  void descriptionChanged(String text) {
    final stale = state.status == LogStatus.result &&
        _analyzedText.isNotEmpty &&
        text.trim() != _analyzedText;
    emit(state.copyWith(description: text, isStale: stale));
  }

  Future<void> startAnalysis() async {
    final text = state.description.trim();
    if (text.isEmpty || _inFlight) return;
    _inFlight = true;
    _analyzedText = text;
    final requestId = ++_requestId;
    _stopwatch = Stopwatch()..start();
    emit(state.copyWith(
      status: LogStatus.analyzing,
      progressStep: 1,
      elapsedSeconds: 0,
      isStale: false,
      isTimeout: false,
      savedMealId: null,
      isDetailsExpanded: false,
    ));
    _startTicker();
    final result = await _repo.analyzeMeal(text);
    if (requestId == _requestId) resultArrived(result);
  }

  void cancelAnalysis() {
    if (state.status != LogStatus.analyzing) return;
    _requestId++;
    _stopTicker();
    _stopwatch?.stop();
    _inFlight = false;
    emit(state.copyWith(
      status: LogStatus.draft,
      progressStep: 1,
      elapsedSeconds: 0,
      isTimeout: false,
    ));
  }

  Future<void> reAnalyze() => startAnalysis();

  void resultArrived(AnalysisResult result) {
    final elapsed = _stopwatch?.elapsed.inSeconds ?? state.elapsedSeconds;
    _stopTicker();
    _stopwatch?.stop();
    _inFlight = false;
    final firstResult = !_disclaimerShown;
    _disclaimerShown = true;
    emit(state.copyWith(
      status: LogStatus.result,
      result: result,
      elapsedSeconds: elapsed,
      isStale: state.description.trim() != _analyzedText,
      isTimeout: false,
      showDisclaimer: firstResult,
    ));
  }

  Future<void> loadTodayMeals() async {
    final rows = await _repo.todayMeals();
    final goal = await _repo.todayGoal();
    emit(state.copyWith(
      todayMeals: rows,
      consumedKcal: _sumKcal(rows),
      goalKcal: goal,
    ));
  }

  /// S05 (§2.5): the button disables via [LogState.isSaving] while writing;
  /// on success the composer resets empty-expanded but the result stays
  /// stashed in state so the undo window can restore the card as it was.
  Future<void> saveMeal() async {
    final result = state.result;
    if (result == null || state.isTimeout || state.isSaving) return;
    emit(state.copyWith(isSaving: true));
    final mealId = await _repo.saveMeal(result);
    if (state.status != LogStatus.result || state.savedMealId != null) {
      emit(state.copyWith(isSaving: false));
      return;
    }
    final row = <String, dynamic>{
      'id': mealId,
      'name': result.descriptionEcho,
      'kcal': result.kcal,
      'time': _timeLabel(DateTime.now()),
    };
    final rows = [row, ...state.todayMeals];
    _analyzedText = '';
    emit(state.copyWith(
      status: LogStatus.saved,
      savedMealId: mealId,
      todayMeals: rows,
      consumedKcal: _sumKcal(rows),
      description: '',
      isSaving: false,
      isStale: false,
      isTimeout: false,
    ));
  }

  /// Deletes the same mealId and brings the card back as it was (§2.5).
  Future<void> undoSave() async {
    final mealId = state.savedMealId;
    final result = state.result;
    if (mealId == null || result == null) return;
    await _repo.undoSave(mealId);
    if (state.savedMealId != mealId) return;
    final rows =
        state.todayMeals.where((row) => row['id'] != mealId).toList();
    _analyzedText = result.descriptionEcho;
    emit(state.copyWith(
      status: LogStatus.result,
      savedMealId: null,
      todayMeals: rows,
      consumedKcal: _sumKcal(rows),
      description: result.descriptionEcho,
      isStale: false,
      isTimeout: false,
    ));
  }

  /// Details toggle lives in the state, not the UI (spec §2.3).
  void toggleDetailsExpanded() =>
      emit(state.copyWith(isDetailsExpanded: !state.isDetailsExpanded));

  /// «اعتمد هذه» — the user accepts the analyzed result despite edits.
  void keepResult() => emit(state.copyWith(isStale: false));

  /// S04 apply (§2.4): swaps [updated] into the analyzed items (matched by
  /// name — mock items are unique) and recomputes the meal totals.
  void applyItemCorrection(MealItem updated) {
    final AnalysisResult? result = state.result;
    if (result == null || state.savedMealId != null) return;
    final List<MealItem> items = [...result.items];
    final int index = items.indexWhere((item) => item.name == updated.name);
    if (index < 0) return;
    items[index] = updated;
    emit(state.copyWith(result: _recalculated(result, items)));
  }

  /// §2.4 instant delete — no confirm; the undo snackbar is the screen's job.
  void removeItem(MealItem item) {
    final AnalysisResult? result = state.result;
    if (result == null || state.savedMealId != null) return;
    final List<MealItem> items = [...result.items];
    final int index = items.indexWhere((it) => it.name == item.name);
    if (index < 0) return;
    _removedItem = items[index];
    _removedIndex = index;
    items.removeAt(index);
    emit(state.copyWith(result: _recalculated(result, items)));
  }

  /// Undo of [removeItem] — the item returns to its old slot.
  void undoRemoveItem() {
    final MealItem? item = _removedItem;
    final int? index = _removedIndex;
    if (item == null || index == null) return;
    _removedItem = null;
    _removedIndex = null;
    final AnalysisResult? result = state.result;
    if (result == null || state.savedMealId != null) return;
    final List<MealItem> items = [...result.items];
    items.insert(index.clamp(0, items.length), item);
    emit(state.copyWith(result: _recalculated(result, items)));
  }

  void clearComposer() {
    _analyzedText = '';
    emit(state.copyWith(
      status: LogStatus.draft,
      description: '',
      result: null,
      progressStep: 1,
      elapsedSeconds: 0,
      isStale: false,
      isTimeout: false,
      savedMealId: null,
    ));
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      final elapsed = _stopwatch?.elapsed ?? Duration.zero;
      if (elapsed >= _timeoutAfter) {
        _emitTimeout();
        return;
      }
      emit(state.copyWith(
        elapsedSeconds: elapsed.inSeconds,
        progressStep: _stepFor(elapsed),
      ));
    });
  }

  void _emitTimeout() {
    _stopTicker();
    _stopwatch?.stop();
    _inFlight = false;
    _requestId++;
    emit(state.copyWith(
      status: LogStatus.result,
      elapsedSeconds: _timeoutAfter.inSeconds,
      progressStep: 3,
      isTimeout: true,
    ));
  }

  void _stopTicker() {
    _ticker?.cancel();
    _ticker = null;
  }

  int _stepFor(Duration elapsed) {
    if (elapsed >= _step3After) return 3;
    if (elapsed >= _step2After) return 2;
    return 1;
  }

  int _sumKcal(List<Map<String, dynamic>> rows) =>
      rows.fold(0, (sum, row) => sum + (row['kcal'] as int? ?? 0));

  // Meal totals after an item change: kcal = Σ items, macros scale with the
  // meal kcal ratio (item macro shares are unknown at this layer — §2.4).
  // TODO(verdict): deck wants verdict/teaser recomputed too — awaits engine.
  AnalysisResult _recalculated(AnalysisResult result, List<MealItem> items) {
    final int newMealKcal = _itemsKcal(items);
    final double scale = result.kcal > 0 ? newMealKcal / result.kcal : 1.0;
    return result.copyWith(
      kcal: newMealKcal,
      proteinGrams: result.proteinGrams * scale,
      carbsGrams: result.carbsGrams * scale,
      fatGrams: result.fatGrams * scale,
      items: items,
    );
  }

  int _itemsKcal(List<MealItem> items) =>
      items.fold(0, (sum, item) => sum + item.kcal);

  String _timeLabel(DateTime time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Future<void> close() {
    _stopTicker();
    _stopwatch?.stop();
    return super.close();
  }
}
