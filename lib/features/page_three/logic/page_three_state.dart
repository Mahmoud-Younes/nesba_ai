part of 'page_three_cubit.dart';

@freezed
class PageThreeState with _$PageThreeState {
  const factory PageThreeState.initial() = _Initial;
  const factory PageThreeState.contentVisibilityChanged(
      {required bool isVisible}) = _ContentVisibilityChanged;
}
