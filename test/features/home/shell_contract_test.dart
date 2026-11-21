// Shell contract (ticket 21 acceptance): one "today" truth for both gates —
// a save on سجّل is what راجع reads, and the log gate sees review deletes.
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/features/home/data/mock_today_data_source.dart';
import 'package:nesba_ai/features/log/data/repos/mock_log_repo.dart';
import 'package:nesba_ai/features/log/logic/log_cubit.dart';
import 'package:nesba_ai/features/review/data/repos/mock_review_repo.dart';
import 'package:nesba_ai/features/review/logic/review_cubit.dart';

void main() {
  setUp(MockTodayDataSource.instance.reset);

  test('a meal saved on the log gate is the meal the review gate reads',
      () async {
    final LogCubit log = LogCubit(MockLogRepo());
    final ReviewCubit review = ReviewCubit(MockReviewRepo());
    await log.loadTodayMeals();
    final int before = log.state.consumedKcal;

    log.resultArrived(await MockLogRepo().analyzeMeal('وجبة اختبار'));
    await log.saveMeal();
    expect(log.state.consumedKcal, before + 430);

    // The gate refresh the shell triggers on arrival re-reads the source.
    await review.load();
    expect(review.state.summary?['consumed'], log.state.consumedKcal);
    expect(review.state.meals.first['id'], log.state.todayMeals.first['id']);
    expect(
      review.state.meals.first['name'],
      log.state.todayMeals.first['name'],
    );
    await log.close();
    await review.close();
  });

  test('review delete is undoable locally and the gates converge on undo',
      () async {
    final LogCubit log = LogCubit(MockLogRepo());
    final ReviewCubit review = ReviewCubit(MockReviewRepo());
    await log.loadTodayMeals();
    await review.load();

    // The mock keeps deletes client-side with the undo snapshot (the real
    // backend will sync them); undo restores the exact pre-delete list.
    review.removeMeal(review.state.meals.first);
    expect(review.state.meals.length, 3);
    review.undoRemoveMeal();
    expect(review.state.meals.length, 4);

    await log.loadTodayMeals();
    expect(log.state.consumedKcal, review.state.summary?['consumed']);
    expect(log.state.todayMeals.length, review.state.meals.length);
    await log.close();
    await review.close();
  });

  test('goal stays unset (0) until settings supplies one', () async {
    final LogCubit log = LogCubit(MockLogRepo());
    final ReviewCubit review = ReviewCubit(MockReviewRepo());
    await log.loadTodayMeals();
    await review.load();
    expect(log.state.goalKcal, 0);
    expect(review.state.summary?['goal'], 0);
    await log.close();
    await review.close();
  });
}
