import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_two_state.dart';
part 'page_two_cubit.freezed.dart';

/// Demo cubit #2: selecting a color from a small palette.
/// The selected index is part of the cubit (not the state)
/// and is emitted inside [PageTwoState.colorChanged].
class PageTwoCubit extends Cubit<PageTwoState> {
  PageTwoCubit() : super(const PageTwoState.initial());

  int selectedColorIndex = 0;

  static const List<Color> palette = [
    Color(0xFF37B673), // green
    Color(0xFF4B4CED), // blue
    Color(0xFFEE637A), // pink
    Color(0xFFF59E0B), // amber
    Color(0xFF8B5CF6), // purple
  ];

  Color get selectedColor => palette[selectedColorIndex];

  void changeColor(int index) {
    selectedColorIndex = index;
    emit(PageTwoState.colorChanged(colorIndex: selectedColorIndex));
  }
}
