import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/helpers/format_helpers.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

// Shared numeric helper lives in core/helpers — re-exported here so the
// existing import sites keep working.
export 'package:nesba_ai/core/helpers/format_helpers.dart' show formatCalories;

/// Ring size — hero 140dp stroke 12 (review), average 96dp stroke 9
/// (week review), or mini 40dp stroke 5 (summary strip), spec §1.5.
enum CalorieRingVariant { hero, average, mini }

/// Calorie progress ring — hero 140dp stroke 12 / mini 40dp stroke 5
/// (spec §1.5). Always clockwise in both locales (no TextDirection involved);
/// state derives from consumed/goal: over → full arc, no goal → track only.
class CalorieRing extends StatelessWidget {
  const CalorieRing({
    required this.consumed,
    required this.goal,
    required this.semanticsLabel,
    this.variant = CalorieRingVariant.hero,
    this.subtitleText,
    super.key,
  });

  final int consumed;

  /// null or ≤ 0 renders the noGoal variant (track only, no arc).
  final int? goal;
  final CalorieRingVariant variant;

  /// Center caption under the number — hero only («من 2,000 سعرة»).
  final String? subtitleText;

  /// Full a11y summary; the ring subtree is excluded from semantics.
  final String semanticsLabel;

  bool get _hasGoal => goal != null && goal! > 0;

  bool get _isOver => _hasGoal && consumed > goal!;

  double get _fraction {
    if (!_hasGoal) {
      return 0;
    }
    final double value = consumed / goal!;
    if (value < 0) {
      return 0;
    }
    if (value > 1) {
      return 1;
    }
    return value;
  }

  double get _dimension => switch (variant) {
        CalorieRingVariant.hero => 140.r,
        CalorieRingVariant.average => 96.r,
        CalorieRingVariant.mini => 40.r,
      };

  double get _strokeWidth => switch (variant) {
        CalorieRingVariant.hero => 12.r,
        CalorieRingVariant.average => 9.r,
        CalorieRingVariant.mini => 5.r,
      };

  // Hero center: 36sp semiBold tabular number + optional caption (spec §2.6).
  Widget _heroCenter(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextApp(
          text: formatCalories(consumed),
          theme: context.textStyle.copyWith(
            fontSize: 36.sp,
            fontWeight: FontWeightHelper.semiBold,
            fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
            color: scheme.onSurface,
          ),
        ),
        if (subtitleText != null) ...<Widget>[
          SizedBox(height: 4.h),
          TextApp(
            text: subtitleText!,
            textAlign: TextAlign.center,
            theme: context.textStyle.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeightHelper.regular,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }

  // Average center: 24sp tabular number (week review §2.7).
  Widget _averageCenter(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return TextApp(
      text: formatCalories(consumed),
      theme: context.textStyle.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeightHelper.semiBold,
        fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
        color: scheme.onSurface,
      ),
    );
  }

  // Mini center: 12sp tabular number (spec §2.0-A).
  Widget _miniCenter(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return TextApp(
      text: formatCalories(consumed),
      theme: context.textStyle.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeightHelper.regular,
        fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
        color: scheme.onSurface,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    // Over goal paints the full circle in overTarget, under goal the fraction
    // in underTarget, no goal leaves the track bare (spec §1.5 CalorieRing).
    return Semantics(
      label: semanticsLabel,
      excludeSemantics: true,
      child: SizedBox.square(
        dimension: _dimension,
        child: CustomPaint(
          painter: _RingPainter(
            trackColor: scheme.outlineVariant,
            arcColor: _isOver
                ? context.color.chartOverTarget!
                : context.color.chartUnderTarget!,
            strokeWidth: _strokeWidth,
            sweepFraction: _isOver ? 1 : _fraction,
          ),
          child: Center(
            child: switch (variant) {
              CalorieRingVariant.hero => _heroCenter(context),
              CalorieRingVariant.average => _averageCenter(context),
              CalorieRingVariant.mini => _miniCenter(context),
            },
          ),
        ),
      ),
    );
  }
}

/// Track + progress arc; a positive sweep from −π/2 keeps the arc clockwise
/// in both locales — the ring never mirrors (spec §5 RTL list).
class _RingPainter extends CustomPainter {
  const _RingPainter({
    required this.trackColor,
    required this.arcColor,
    required this.strokeWidth,
    required this.sweepFraction,
  });

  final Color trackColor;
  final Color arcColor;
  final double strokeWidth;
  final double sweepFraction;

  @override
  void paint(Canvas canvas, Size size) {
    final double inset = strokeWidth / 2;
    final Rect rect =
        Offset(inset, inset) &
        Size(size.width - strokeWidth, size.height - strokeWidth);
    final Paint track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = trackColor;
    canvas.drawCircle(rect.center, rect.shortestSide / 2, track);
    if (sweepFraction <= 0) {
      return;
    }
    final Paint arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = arcColor;
    canvas.drawArc(rect, -math.pi / 2, 2 * math.pi * sweepFraction, false, arc);
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.trackColor != trackColor ||
        oldDelegate.arcColor != arcColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.sweepFraction != sweepFraction;
  }
}
