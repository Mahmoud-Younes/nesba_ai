import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_one_state.dart';
part 'page_one_cubit.freezed.dart';

/// Demo cubit #1: a counter. Every method emits a new
/// [PageOneState] with the updated value.
class PageOneCubit extends Cubit<PageOneState> {
  PageOneCubit() : super(const PageOneState.initial());

  int counter = 0;

  void increment() {
    counter++;
    emit(PageOneState.counterChanged(counter: counter));
  }

  void decrement() {
    counter--;
    emit(PageOneState.counterChanged(counter: counter));
  }

  void reset() {
    counter = 0;
    emit(PageOneState.counterChanged(counter: counter));
  }
}
