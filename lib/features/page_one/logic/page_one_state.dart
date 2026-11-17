part of 'page_one_cubit.dart';

@freezed
class PageOneState with _$PageOneState {
  const factory PageOneState.initial() = _Initial;
  const factory PageOneState.counterChanged({required int counter}) =
      _CounterChanged;
}
