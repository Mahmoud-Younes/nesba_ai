import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/features/review/data/repos/mock_review_repo.dart';
import 'package:nesba_ai/features/review/logic/review_cubit.dart';

void main() {
  test('load shows the skeleton then swaps in meals, summary and macros',
      () async {
    final cubit = ReviewCubit(MockReviewRepo());
    final future = cubit.load();
    expect(cubit.state.isLoading, true); // skeleton before any data
    expect(cubit.state.meals, isEmpty);
    await future;
    expect(cubit.state.isLoading, false);
    expect(cubit.state.meals.length, 4);
    expect(cubit.state.meals[0]['id'], 'mock_review_101');
    expect(cubit.state.summary?['consumed'], 1240);
    expect(cubit.state.summary?['goal'], 2000);
    expect(cubit.state.macros, (protein: 78, carbs: 120, fat: 64));
    await cubit.close();
  });

  test('second load skips the skeleton and swaps in place', () async {
    final cubit = ReviewCubit(MockReviewRepo());
    await cubit.load();
    final second = cubit.load();
    expect(cubit.state.isLoading, false); // no skeleton on re-read
    await second;
    expect(cubit.state.isLoading, false);
    expect(cubit.state.meals.length, 4);
    await cubit.close();
  });

  test('toggleMode switches day/week and clears weekly data', () async {
    final cubit = ReviewCubit(MockReviewRepo());
    expect(cubit.state.mode, ReviewMode.day);
    cubit.toggleMode(ReviewMode.week);
    expect(cubit.state.mode, ReviewMode.week);
    expect(cubit.state.weeklyData, isEmpty);
    cubit.toggleMode(ReviewMode.day);
    expect(cubit.state.mode, ReviewMode.day);
    await cubit.close();
  });

  test('removeMeal deletes by id and undoRemoveMeal restores the index',
      () async {
    final cubit = ReviewCubit(MockReviewRepo());
    await cubit.load();
    cubit.removeMeal(<String, dynamic>{'id': 'unknown_id'}); // no-op
    expect(cubit.state.meals.length, 4);
    final target = cubit.state.meals[1]; // mock_review_102
    cubit.removeMeal(target);
    expect(cubit.state.meals.length, 3);
    expect(
      cubit.state.meals.any((meal) => meal['id'] == 'mock_review_102'),
      false,
    );
    cubit.undoRemoveMeal();
    expect(cubit.state.meals.length, 4);
    expect(cubit.state.meals[1]['id'], 'mock_review_102'); // same slot
    expect(cubit.state.meals[1], same(target));
    await cubit.close();
  });

  test('undoRemoveMeal without a prior removal is a no-op', () async {
    final cubit = ReviewCubit(MockReviewRepo());
    await cubit.load();
    cubit.undoRemoveMeal();
    expect(cubit.state.meals.length, 4);
    await cubit.close();
  });
}
