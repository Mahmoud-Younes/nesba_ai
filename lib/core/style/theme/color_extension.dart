import 'package:flutter/material.dart';
import 'package:nesba_ai/core/style/colors/colors_dark.dart';
import 'package:nesba_ai/core/style/colors/colors_light.dart';


class MyColors extends ThemeExtension<MyColors> {
  const MyColors({
    required this.mainColor,
    required this.greenDark,
    required this.greenLight,
    required this.textColor,
    required this.textFormBorder,
    required this.containerLinear1,
    required this.containerLinear2,
    required this.chartProtein,
    required this.chartCarbohydrate,
    required this.chartFat,
    required this.chartUnderTarget,
    required this.chartOverTarget,
  });

  final Color? mainColor;
  final Color? greenDark;
  final Color? greenLight;
  final Color? textColor;
  final Color? textFormBorder;
  final Color? containerLinear1;
  final Color? containerLinear2;

  // nes.chart semantic colors — Bustan §1.2.
  final Color? chartProtein;
  final Color? chartCarbohydrate;
  final Color? chartFat;
  final Color? chartUnderTarget;
  final Color? chartOverTarget;

  @override
  ThemeExtension<MyColors> copyWith({
    Color? mainColor,
    Color? greenDark,
    Color? greenLight,
    Color? textColor,
    Color? textFormBorder,
    Color? containerLinear1,
    Color? containerLinear2,
    Color? chartProtein,
    Color? chartCarbohydrate,
    Color? chartFat,
    Color? chartUnderTarget,
    Color? chartOverTarget,
  }) {
    return MyColors(
      mainColor: mainColor,
      greenDark: greenDark,
      greenLight: greenLight,
      textColor: textColor,
      textFormBorder: textFormBorder,
      containerLinear1: containerLinear1,
      containerLinear2: containerLinear2,
      chartProtein: chartProtein,
      chartCarbohydrate: chartCarbohydrate,
      chartFat: chartFat,
      chartUnderTarget: chartUnderTarget,
      chartOverTarget: chartOverTarget,
    );
  }

  @override
  ThemeExtension<MyColors> lerp(
    covariant ThemeExtension<MyColors>? other,
    double t,
  ) {
    if (other is! MyColors) {
      return this;
    }
    Color? blend(Color? a, Color? b) => Color.lerp(a, b, t);
    return MyColors(
      mainColor: blend(mainColor, other.mainColor),
      greenDark: blend(greenDark, other.greenDark),
      greenLight: blend(greenLight, other.greenLight),
      textColor: blend(textColor, other.textColor),
      textFormBorder: blend(textFormBorder, other.textFormBorder),
      containerLinear1: blend(containerLinear1, other.containerLinear1),
      containerLinear2: blend(containerLinear2, other.containerLinear2),
      chartProtein: blend(chartProtein, other.chartProtein),
      chartCarbohydrate: blend(chartCarbohydrate, other.chartCarbohydrate),
      chartFat: blend(chartFat, other.chartFat),
      chartUnderTarget: blend(chartUnderTarget, other.chartUnderTarget),
      chartOverTarget: blend(chartOverTarget, other.chartOverTarget),
    );
  }

  static const MyColors dark = MyColors(
    mainColor: ColorsDark.mainColor,
    greenDark: ColorsDark.greenDark,
    greenLight: ColorsDark.greenLight,
    textColor: ColorsDark.white,
    textFormBorder: ColorsDark.greenLight,
    containerLinear1: ColorsDark.black1,
    containerLinear2: ColorsDark.black2,
    chartProtein: ColorsDark.chartProtein,
    chartCarbohydrate: ColorsDark.chartCarbohydrate,
    chartFat: ColorsDark.chartFat,
    chartUnderTarget: ColorsDark.chartUnderTarget,
    chartOverTarget: ColorsDark.chartOverTarget,
  );

  static const MyColors light = MyColors(
    mainColor: ColorsLight.mainColor,
    greenDark: ColorsLight.greenDark,
    greenLight: ColorsLight.greenLight,
    textColor: ColorsLight.black,
    textFormBorder: ColorsLight.greenLight,
    containerLinear1: ColorsLight.greenDark,
    containerLinear2: ColorsLight.greenLight,
    chartProtein: ColorsLight.chartProtein,
    chartCarbohydrate: ColorsLight.chartCarbohydrate,
    chartFat: ColorsLight.chartFat,
    chartUnderTarget: ColorsLight.chartUnderTarget,
    chartOverTarget: ColorsLight.chartOverTarget,
  );
}
