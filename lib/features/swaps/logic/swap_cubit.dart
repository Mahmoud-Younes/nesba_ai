import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
      emit(state.copyWith(isLoading: false, swaps: swaps, errorMsg: null));
    } on Exception {
      // Every failure renders as the server card; previous swaps stay.
      emit(state.copyWith(isLoading: false, errorMsg: 'server'));
    }
  }

  // TODO(log): «تبديل» adds the alternative as a meal through the save
  // path (undoable) — lands with ticket 21, out of scope here.
  void applySwap(int index) {}

  void toggleBookmark(int index) {
    final Set<int> bookmarked = Set<int>.of(state.bookmarked);
    if (!bookmarked.remove(index)) {
      bookmarked.add(index);
    }
    emit(state.copyWith(bookmarked: bookmarked));
  }
}
