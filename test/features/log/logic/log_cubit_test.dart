import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/features/log/data/models/analysis_result.dart';
import 'package:nesba_ai/features/log/data/models/meal_item.dart';
import 'package:nesba_ai/features/log/data/repos/log_repo.dart';
import 'package:nesba_ai/features/log/data/repos/mock_log_repo.dart';
import 'package:nesba_ai/features/log/logic/log_cubit.dart';

/// analyzeMeal never resolves — the ticker keeps ticking until close().
class _NeverResolvingLogRepo implements LogRepo {
  @override
  Future<AnalysisResult> analyzeMeal(String description) =>
      Completer<AnalysisResult>().future;

  @override
  Future<String> saveMeal(AnalysisResult result) async => 'unused_id';

  @override
  Future<void> undoSave(String mealId) async {}

  @override
  Future<List<Map<String, dynamic>>> todayMeals() async =>
      <Map<String, dynamic>>[];
}

/// First analysis resolves instantly, the second hangs forever.
class _HangsOnSecondLogRepo implements LogRepo {
  _HangsOnSecondLogRepo(this._first);

  final AnalysisResult _first;
  int _calls = 0;

  @override
  Future<AnalysisResult> analyzeMeal(String description) async {
    _calls++;
    if (_calls == 1) return _first;
    return Completer<AnalysisResult>().future;
  }

  @override
  Future<String> saveMeal(AnalysisResult result) async => 'unused_id';

  @override
  Future<void> undoSave(String mealId) async {}

  @override
  Future<List<Map<String, dynamic>>> todayMeals() async =>
      <Map<String, dynamic>>[];
}

/// analyzeMeal resolves only when the test completes the gate.
class _GatedLogRepo implements LogRepo {
  _GatedLogRepo(this._gate);

  final Completer<AnalysisResult> _gate;

  @override
  Future<AnalysisResult> analyzeMeal(String description) => _gate.future;

  @override
  Future<String> saveMeal(AnalysisResult result) async => 'unused_id';

  @override
  Future<void> undoSave(String mealId) async {}

  @override
  Future<List<Map<String, dynamic>>> todayMeals() async =>
      <Map<String, dynamic>>[];
}

const AnalysisResult _result = AnalysisResult(
  descriptionEcho: 'بيض وتوست وعصير برتقال',
  kcal: 430,
  verdict: VerdictLevel.acceptable,
  proteinGrams: 22,
  carbsGrams: 55,
  fatGrams: 13,
  items: [
    MealItem(
      name: 'بيض مسلوق',
      quantityMultiplier: 2,
      unit: MealUnit.piece,
      kcal: 156,
    ),
    MealItem(
      name: 'توست أسمر',
      quantityMultiplier: 2,
      unit: MealUnit.piece,
      kcal: 150,
      isLowConfidence: true,
    ),
    MealItem(
      name: 'عصير برتقال',
      quantityMultiplier: 1,
      grams: 248,
      unit: MealUnit.cup,
      kcal: 124,
    ),
  ],
  advice: 'الوجبة قريبة من المتوازن',
  verdictWhy: 'البروتين جيد',
);

// Runs the full analyze path against MockLogRepo (2.5s latency).
// fakeAsync fakes the mock's Future.delayed and microtasks; the cubit's
// Stopwatch stays real, so the step/timeout ticks live in real-time tests.
LogCubit _analyzedCubit(FakeAsync async) {
  final cubit = LogCubit(MockLogRepo());
  cubit.descriptionChanged('بيض وتوست وعصير برتقال');
  unawaited(cubit.startAnalysis());
  async.elapse(const Duration(milliseconds: 2500));
  return cubit;
}

void main() {
  test(
    'progress step climbs to 2 at 3s and to 3 at 8s while analyzing',
    () async {
      final cubit = LogCubit(_NeverResolvingLogRepo());
      cubit.descriptionChanged('وجبة انتظار طويل');
      unawaited(cubit.startAnalysis());
      expect(cubit.state.status, LogStatus.analyzing);
      expect(cubit.state.progressStep, 1);
      expect(cubit.state.elapsedSeconds, 0);
      await Future<void>.delayed(const Duration(milliseconds: 3200));
      expect(cubit.state.progressStep, 2);
      expect(cubit.state.elapsedSeconds, 3);
      expect(cubit.state.isTimeout, false);
      await Future<void>.delayed(const Duration(seconds: 5));
      expect(cubit.state.progressStep, 3);
      expect(cubit.state.elapsedSeconds, 8);
      expect(cubit.state.status, LogStatus.analyzing);
      expect(cubit.state.isTimeout, false);
      await cubit.close();
    },
    timeout: Timeout(Duration(minutes: 2)),
  );

  test(
    'timeout at 45s flips isTimeout and keeps the previous result',
    () async {
      final cubit = LogCubit(_HangsOnSecondLogRepo(_result));
      cubit.descriptionChanged('وجبة تتجاوز المهلة');
      await cubit.startAnalysis(); // the first analysis resolves instantly
      expect(cubit.state.status, LogStatus.result);
      expect(cubit.state.result, same(_result));
      unawaited(cubit.reAnalyze()); // this one hangs forever
      await Future<void>.delayed(const Duration(milliseconds: 3200));
      expect(cubit.state.progressStep, 2); // ticker still alive
      await Future<void>.delayed(const Duration(seconds: 5));
      expect(cubit.state.progressStep, 3);
      await Future<void>.delayed(const Duration(milliseconds: 37300));
      expect(cubit.state.isTimeout, true);
      expect(cubit.state.status, LogStatus.result);
      expect(cubit.state.elapsedSeconds, 45);
      expect(cubit.state.progressStep, 3);
      expect(cubit.state.result, same(_result)); // the old result stays
      await cubit.close();
    },
    timeout: Timeout(Duration(minutes: 2)),
  );

  test('startAnalysis goes analyzing then lands the mock result', () {
    fakeAsync((async) {
      final cubit = _analyzedCubit(async);
      expect(cubit.state.status, LogStatus.result);
      expect(cubit.state.result?.kcal, 430);
      expect(cubit.state.result?.descriptionEcho, 'بيض وتوست وعصير برتقال');
      expect(cubit.state.result?.items.length, 3);
      expect(cubit.state.showDisclaimer, true); // first result only
      expect(cubit.state.isStale, false);
      expect(cubit.state.isTimeout, false);
      unawaited(cubit.close());
    });
  });

  test('showDisclaimer rides the first result only', () {
    fakeAsync((async) {
      final cubit = _analyzedCubit(async);
      expect(cubit.state.showDisclaimer, true);
      unawaited(cubit.reAnalyze());
      async.elapse(const Duration(milliseconds: 2500));
      expect(cubit.state.showDisclaimer, false);
      unawaited(cubit.close());
    });
  });

  test('cancelAnalysis invalidates the late result through requestId', () {
    fakeAsync((async) {
      final gate = Completer<AnalysisResult>();
      final cubit = LogCubit(_GatedLogRepo(gate));
      cubit.descriptionChanged('وجبة تُلغى');
      unawaited(cubit.startAnalysis());
      expect(cubit.state.status, LogStatus.analyzing);
      cubit.cancelAnalysis();
      expect(cubit.state.status, LogStatus.draft);
      expect(cubit.state.progressStep, 1);
      expect(cubit.state.elapsedSeconds, 0);
      expect(cubit.state.isTimeout, false);
      gate.complete(_result);
      async.flushMicrotasks();
      // the late result is dropped — the request id no longer matches
      expect(cubit.state.status, LogStatus.draft);
      expect(cubit.state.result, isNull);
      expect(cubit.state.isStale, false);
      unawaited(cubit.close());
    });
  });

  test('editing during analysis never cancels the request and lands stale',
      () {
    fakeAsync((async) {
      final cubit = LogCubit(MockLogRepo());
      const text = 'وجبة اختبار للتحليل';
      cubit.descriptionChanged(text);
      unawaited(cubit.startAnalysis());
      async.elapse(const Duration(milliseconds: 500));
      cubit.descriptionChanged('نص مختلف تمامًا');
      expect(cubit.state.status, LogStatus.analyzing); // request still live
      expect(cubit.state.isStale, false);
      async.elapse(const Duration(milliseconds: 2000));
      expect(cubit.state.status, LogStatus.result);
      expect(cubit.state.result, isNotNull);
      expect(cubit.state.isStale, true); // arrival compares vs analyzed text
      cubit.descriptionChanged(text);
      expect(cubit.state.isStale, false);
      unawaited(cubit.close());
    });
  });

  test('stale flips off the analyzed echo and keepResult accepts the card',
      () {
    fakeAsync((async) {
      final cubit = _analyzedCubit(async);
      const text = 'بيض وتوست وعصير برتقال';
      cubit.descriptionChanged('كوب شاي بسكر');
      expect(cubit.state.isStale, true);
      cubit.descriptionChanged(text);
      expect(cubit.state.isStale, false);
      cubit.descriptionChanged('كوب شاي بسكر');
      expect(cubit.state.isStale, true);
      cubit.keepResult();
      expect(cubit.state.isStale, false);
      unawaited(cubit.close());
    });
  });

  test('loadTodayMeals seeds the ledger rows and consumed kcal', () {
    fakeAsync((async) {
      final cubit = LogCubit(MockLogRepo());
      expect(cubit.state.consumedKcal, 0);
      unawaited(cubit.loadTodayMeals());
      async.flushMicrotasks();
      expect(cubit.state.todayMeals.length, 2);
      expect(cubit.state.todayMeals[0]['id'], 'mock_meal_101');
      expect(cubit.state.consumedKcal, 470);
      unawaited(cubit.close());
    });
  });

  test('saveMeal appends the meal row and resets the composer', () {
    fakeAsync((async) {
      final cubit = LogCubit(MockLogRepo());
      unawaited(cubit.loadTodayMeals());
      async.flushMicrotasks();
      expect(cubit.state.consumedKcal, 470);
      cubit.descriptionChanged('بيض وتوست وعصير برتقال');
      unawaited(cubit.startAnalysis());
      async.elapse(const Duration(milliseconds: 2500));
      unawaited(cubit.saveMeal());
      expect(cubit.state.isSaving, true); // button disabled while writing
      async.elapse(const Duration(milliseconds: 400));
      expect(cubit.state.status, LogStatus.saved);
      expect(cubit.state.savedMealId, 'mock_meal_001');
      expect(cubit.state.todayMeals.length, 3);
      expect(cubit.state.todayMeals.first['id'], 'mock_meal_001');
      expect(cubit.state.todayMeals.first['name'], 'بيض وتوست وعصير برتقال');
      expect(cubit.state.todayMeals.first['kcal'], 430);
      expect(cubit.state.todayMeals.first['time'], matches(RegExp(r'^\d{2}:\d{2}$')));
      expect(cubit.state.consumedKcal, 900);
      expect(cubit.state.description, '');
      expect(cubit.state.isSaving, false);
      expect(cubit.state.isStale, false);
      unawaited(cubit.close());
    });
  });

  test('double save is guarded and leaves the ledger untouched', () {
    fakeAsync((async) {
      final cubit = LogCubit(MockLogRepo());
      cubit.descriptionChanged('بيض وتوست وعصير برتقال');
      unawaited(cubit.startAnalysis());
      async.elapse(const Duration(milliseconds: 2500));
      unawaited(cubit.saveMeal());
      async.elapse(const Duration(milliseconds: 400));
      expect(cubit.state.status, LogStatus.saved);
      unawaited(cubit.saveMeal()); // second press on the same meal
      expect(cubit.state.isSaving, true);
      async.elapse(const Duration(milliseconds: 400));
      expect(cubit.state.isSaving, false);
      expect(cubit.state.savedMealId, 'mock_meal_001');
      expect(cubit.state.todayMeals.length, 1); // no duplicate row
      expect(cubit.state.consumedKcal, 430);
      unawaited(cubit.close());
    });
  });

  test('undoSave removes the same mealId and restores the result card', () {
    fakeAsync((async) {
      final cubit = LogCubit(MockLogRepo());
      unawaited(cubit.loadTodayMeals());
      async.flushMicrotasks();
      cubit.descriptionChanged('بيض وتوست وعصير برتقال');
      unawaited(cubit.startAnalysis());
      async.elapse(const Duration(milliseconds: 2500));
      unawaited(cubit.saveMeal());
      async.elapse(const Duration(milliseconds: 400));
      expect(cubit.state.todayMeals.length, 3);
      unawaited(cubit.undoSave());
      async.flushMicrotasks();
      expect(cubit.state.status, LogStatus.result);
      expect(cubit.state.savedMealId, isNull);
      expect(cubit.state.todayMeals.length, 2);
      expect(
        cubit.state.todayMeals.any((row) => row['id'] == 'mock_meal_001'),
        false,
      );
      expect(cubit.state.consumedKcal, 470);
      expect(cubit.state.description, 'بيض وتوست وعصير برتقال');
      expect(cubit.state.isStale, false);
      unawaited(cubit.close());
    });
  });

  test('applyItemCorrection swaps the item and recalculates meal kcal', () {
    final cubit = LogCubit(MockLogRepo());
    cubit.resultArrived(_result);
    final corrected = _result.items[0].copyWith(kcal: 300, isEdited: true);
    cubit.applyItemCorrection(corrected);
    expect(cubit.state.result?.kcal, 574); // 300 + 150 + 124
    expect(cubit.state.result?.items[0], same(corrected));
    expect(cubit.state.result?.items[0].isEdited, true);
    // macros scale with the meal ratio 574/430
    expect(cubit.state.result?.proteinGrams, closeTo(22 * 574 / 430, 0.01));
    expect(cubit.state.result?.carbsGrams, closeTo(55 * 574 / 430, 0.01));
    expect(cubit.state.result?.fatGrams, closeTo(13 * 574 / 430, 0.01));
    unawaited(cubit.close());
  });

  test('applyItemCorrection with an unknown name is a no-op', () {
    final cubit = LogCubit(MockLogRepo());
    cubit.resultArrived(_result);
    const stranger = MealItem(
      name: 'أرز أبيض',
      quantityMultiplier: 1,
      unit: MealUnit.cup,
      kcal: 999,
    );
    cubit.applyItemCorrection(stranger);
    expect(cubit.state.result?.kcal, 430);
    expect(cubit.state.result?.items.length, 3);
    unawaited(cubit.close());
  });

  test('removeItem deletes instantly and undoRemoveItem restores the slot',
      () {
    final cubit = LogCubit(MockLogRepo());
    cubit.resultArrived(_result);
    final toast = _result.items[1];
    cubit.removeItem(toast);
    expect(cubit.state.result?.kcal, 280); // 156 + 124
    expect(
      cubit.state.result?.items.map((item) => item.name).toList(),
      ['بيض مسلوق', 'عصير برتقال'],
    );
    cubit.undoRemoveItem();
    expect(cubit.state.result?.items.length, 3);
    expect(cubit.state.result?.items[1], same(toast)); // exact old slot
    expect(cubit.state.result?.items[1].isLowConfidence, true);
    expect(cubit.state.result?.kcal, 430);
    cubit.undoRemoveItem(); // nothing left to restore
    expect(cubit.state.result?.items.length, 3);
    unawaited(cubit.close());
  });

  test('toggleDetailsExpanded flips the flag in state', () {
    final cubit = LogCubit(MockLogRepo());
    expect(cubit.state.isDetailsExpanded, false);
    cubit.toggleDetailsExpanded();
    expect(cubit.state.isDetailsExpanded, true);
    cubit.toggleDetailsExpanded();
    expect(cubit.state.isDetailsExpanded, false);
    unawaited(cubit.close());
  });

  test('clearComposer resets the composer to a clean draft', () {
    final cubit = LogCubit(MockLogRepo());
    cubit.resultArrived(_result);
    cubit.descriptionChanged('نص مختلف');
    cubit.clearComposer();
    expect(cubit.state.status, LogStatus.draft);
    expect(cubit.state.description, '');
    expect(cubit.state.result, isNull);
    expect(cubit.state.savedMealId, isNull);
    expect(cubit.state.isStale, false);
    expect(cubit.state.isTimeout, false);
    expect(cubit.state.progressStep, 1);
    expect(cubit.state.elapsedSeconds, 0);
    unawaited(cubit.close());
  });
}
