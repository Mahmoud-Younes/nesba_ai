import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Result-card footprint placeholder (~272dp); manual shimmer, endpoints ≥3:1,
/// static color when animations are disabled.
class SkeletonCard extends StatefulWidget {
  const SkeletonCard({super.key});

  @override
  State<SkeletonCard> createState() => _SkeletonCardState();
}

class _SkeletonCardState extends State<SkeletonCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmer = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _shimmer.stop();
    } else if (!_shimmer.isAnimating) {
      _shimmer.repeat();
    }
  }

  @override
  void dispose() {
    _shimmer.dispose();
    super.dispose();
  }

  double _relLum(Color c) {
    double f(double v) => v <= 0.04045
        ? v / 12.92
        : math.pow((v + 0.055) / 1.055, 2.4).toDouble();
    return 0.2126 * f(c.r) + 0.7152 * f(c.g) + 0.0722 * f(c.b);
  }

  double _contrast(Color a, Color b) {
    final double la = _relLum(a);
    final double lb = _relLum(b);
    return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
  }

  // Minimal onSurface alpha over [surface] reaching the contrast target.
  Color _blendForContrast(Color fg, Color surface, double target) {
    double lo = 0;
    double hi = 1;
    for (int i = 0; i < 20; i++) {
      final double mid = (lo + hi) / 2;
      final Color candidate =
          Color.alphaBlend(fg.withValues(alpha: mid), surface);
      if (_contrast(candidate, surface) >= target) {
        hi = mid;
      } else {
        lo = mid;
      }
    }
    return Color.alphaBlend(fg.withValues(alpha: hi), surface);
  }

  Gradient _sweep(Color base, Color highlight) {
    final double center = -1.5 + 3.0 * _shimmer.value;
    return LinearGradient(
      begin: AlignmentDirectional(center - 0.75, 0),
      end: AlignmentDirectional(center + 0.75, 0),
      colors: [base, highlight, base],
      stops: const [0.0, 0.5, 1.0],
    );
  }

  Widget _lineBox(double height, Color color, Gradient? gradient) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4.r),
        gradient: gradient,
      ),
    );
  }

  Widget _line(
    double widthFactor,
    double height,
    Color base,
    Color highlight,
    bool reduceMotion,
  ) {
    final Widget line = reduceMotion
        ? _lineBox(height, base, null)
        : AnimatedBuilder(
            animation: _shimmer,
            builder: (context, _) => _lineBox(height, base, _sweep(base, highlight)),
          );
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: FractionallySizedBox(widthFactor: widthFactor, child: line),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Color surface = scheme.surfaceContainer;
    final Color base = _blendForContrast(scheme.onSurface, surface, 3.0);
    final Color highlight = _blendForContrast(scheme.onSurface, surface, 4.5);
    final bool reduceMotion = MediaQuery.disableAnimationsOf(context);
    return Container(
      width: double.infinity,
      height: 272.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _line(0.45, 16.h, base, highlight, reduceMotion),
          SizedBox(height: 16.h),
          _line(1.0, 12.h, base, highlight, reduceMotion),
          SizedBox(height: 12.h),
          _line(0.82, 12.h, base, highlight, reduceMotion),
        ],
      ),
    );
  }
}
