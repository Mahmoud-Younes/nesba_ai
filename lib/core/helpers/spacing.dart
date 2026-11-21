import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Spacing tokens from Bustan spec §1.4.
///
/// 4dp base grid with scale {4, 8, 12, 16, 24, 32, 48} — same scale as
/// `08` §8.5.3 (documentation, not invention).
class AppSpacing {
  const AppSpacing._();

  // 4dp scale.
  static const double s4 = 4;
  static const double s8 = 8;
  static const double s12 = 12;
  static const double s16 = 16;
  static const double s24 = 24;
  static const double s32 = 32;
  static const double s48 = 48;

  // Semantic spacing (Bustan §1.4).
  static const double screenEdge = 16;
  static const double cardInner = 16;
  static const double listDivider = 12;
  static const double sectionDivider = 24;
}

/// Vertical spacing with responsive height (`.h`).
SizedBox verticalSpace(double height) => SizedBox(height: height.h);

/// Horizontal spacing with responsive width (`.w`).
SizedBox horizontalSpace(double width) => SizedBox(width: width.w);
