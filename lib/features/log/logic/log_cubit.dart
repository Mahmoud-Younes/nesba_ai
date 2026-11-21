import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nesba_ai/features/log/data/models/analysis_result.dart';
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
  bool _saving = false;

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
    emit(state.copyWith(
      status: LogStatus.result,
      result: result,
      elapsedSeconds: elapsed,
      isStale: state.description.trim() != _analyzedText,
      isTimeout: false,
    ));
  }

  Future<void> loadTodayMeals() async {
    final rows = await _repo.todayMeals();
    emit(state.copyWith(todayMeals: rows, consumedKcal: _sumKcal(rows)));
  }

  Future<void> saveMeal() async {
    final result = state.result;
    if (result == null || state.isTimeout || _saving) return;
    _saving = true;
    final mealId = await _repo.saveMeal(result);
    _saving = false;
    if (state.status != LogStatus.result || state.savedMealId != null) return;
    final row = <String, dynamic>{
      'id': mealId,
      'name': result.descriptionEcho,
      'kcal': result.kcal,
      'time': _timeLabel(DateTime.now()),
    };
    final rows = [row, ...state.todayMeals];
    emit(state.copyWith(
      status: LogStatus.saved,
      savedMealId: mealId,
      todayMeals: rows,
      consumedKcal: _sumKcal(rows),
    ));
  }

  Future<void> undoSave() async {
    final mealId = state.savedMealId;
    if (mealId == null) return;
    await _repo.undoSave(mealId);
    if (state.savedMealId != mealId) return;
    final rows =
        state.todayMeals.where((row) => row['id'] != mealId).toList();
    emit(state.copyWith(
      status: LogStatus.result,
      savedMealId: null,
      todayMeals: rows,
      consumedKcal: _sumKcal(rows),
    ));
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
