import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nesba_ai/core/helpers/app_logger.dart';
import 'package:nesba_ai/features/swaps/data/repos/swap_repo.dart';

part 'swap_cubit.freezed.dart';
part 'swap_state.dart';

/// Drives the suggestions gate: pair cards + bookmark toggles (S08,
/// spec §2.8).
class SwapCubit extends Cubit<SwapState> {
  SwapCubit(this._repo) : super(const SwapState());

  final SwapRepo _repo;

  // Skeleton rides the first read only — later loads swap in place.
  bool _hasLoaded = false;

  Future<void> load() async {
    final bool firstRead = !_hasLoaded;
    if (firstRead) {
      emit(state.copyWith(isLoading: true, errorMsg: null));
    }
    try {
      final List<Map<String, dynamic>> swaps = await _repo.swaps();
      _hasLoaded = true;
      appLog('swaps loaded: ${swaps.length} pairs');
      emit(state.copyWith(isLoading: false, swaps: swaps, errorMsg: null));
    } on Exception catch (error) {
      // Every failure renders as the server card; previous swaps stay.
      AppLogger.error('swaps load failed', error);
      emit(state.copyWith(isLoading: false, errorMsg: 'server'));
    }
  }

  // TODO(save-path): «تبديل» adds the alternative as a meal through the
  // log gate's save flow (undoable) — follow-up to ticket 19, out of scope
  // in this UI branch.
  void applySwap(int index) {}

  // Bookmarks key on the pair id (stable across refetch/reorder), not the
  // list index.
  void toggleBookmark(String pairId) {
    final Set<String> bookmarked = Set<String>.of(state.bookmarked);
    if (!bookmarked.remove(pairId)) {
      bookmarked.add(pairId);
    }
    emit(state.copyWith(bookmarked: bookmarked));
  }
}
