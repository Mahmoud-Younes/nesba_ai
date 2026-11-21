import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/features/swaps/data/repos/mock_swap_repo.dart';
import 'package:nesba_ai/features/swaps/logic/swap_cubit.dart';

/// Succeeds on the first read, throws on every later one — the failure
/// path must keep the previous swaps visible.
class _FailsOnSecondSwapRepo extends MockSwapRepo {
  int _calls = 0;

  @override
  Future<List<Map<String, dynamic>>> swaps() async {
    _calls++;
    if (_calls > 1) throw Exception('server down');
    return super.swaps();
  }
}

void main() {
  test('load shows the skeleton then the pair cards', () async {
    final cubit = SwapCubit(MockSwapRepo());
    final future = cubit.load();
    expect(cubit.state.isLoading, true); // skeleton before any data
    expect(cubit.state.swaps, isEmpty);
    await future;
    expect(cubit.state.isLoading, false);
    expect(cubit.state.swaps.length, 3);
    expect(cubit.state.swaps[0]['id'], 'mock_swap_101');
    expect(cubit.state.errorMsg, isNull);
    await cubit.close();
  });

  test('toggleBookmark flips indexes in and out of the set', () async {
    final cubit = SwapCubit(MockSwapRepo());
    expect(cubit.state.bookmarked, isEmpty);
    cubit.toggleBookmark('mock_swap_100');
    expect(cubit.state.bookmarked, <String>{'mock_swap_101'});
    cubit.toggleBookmark('mock_swap_100');
    expect(cubit.state.bookmarked, isEmpty);
    cubit.toggleBookmark('mock_swap_101');
    cubit.toggleBookmark('mock_swap_102');
    expect(cubit.state.bookmarked, <String>{'mock_swap_102', 'mock_swap_103'});
    await cubit.close();
  });

  test('load failure marks the server error and keeps previous swaps',
      () async {
    final cubit = SwapCubit(_FailsOnSecondSwapRepo());
    await cubit.load();
    expect(cubit.state.swaps.length, 3);
    expect(cubit.state.errorMsg, isNull);
    await cubit.load(); // this one throws inside the repo
    expect(cubit.state.isLoading, false);
    expect(cubit.state.errorMsg, 'server');
    expect(cubit.state.swaps.length, 3); // previous swaps stay visible
    await cubit.close();
  });
}
