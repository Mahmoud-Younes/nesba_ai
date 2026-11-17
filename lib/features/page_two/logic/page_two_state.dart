part of 'page_two_cubit.dart';

@freezed
class PageTwoState with _$PageTwoState {
  const factory PageTwoState.initial() = _Initial;
  const factory PageTwoState.colorChanged({required int colorIndex}) =
      _ColorChanged;
}
