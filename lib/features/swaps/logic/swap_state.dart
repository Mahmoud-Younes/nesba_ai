part of 'swap_cubit.dart';

@freezed
abstract class SwapState with _$SwapState {
  const factory SwapState({
    @Default(false) bool isLoading,
    @Default(<Map<String, dynamic>>[]) List<Map<String, dynamic>> swaps,
    @Default(<int>{}) Set<int> bookmarked,

    /// Non-null marker for any load failure — the screen renders the
    /// err_server_* card while previous swaps stay visible (§2.8).
    String? errorMsg,
  }) = _SwapState;
}
