import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_three_state.dart';
part 'page_three_cubit.freezed.dart';

/// Demo cubit #3: a boolean state (show / hide some content).
class PageThreeCubit extends Cubit<PageThreeState> {
  PageThreeCubit() : super(const PageThreeState.initial());

  bool isContentVisible = true;

  void toggleContentVisibility() {
    isContentVisible = !isContentVisible;
    emit(PageThreeState.contentVisibilityChanged(isVisible: isContentVisible));
  }
}
