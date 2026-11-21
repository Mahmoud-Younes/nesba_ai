import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/core/style/theme/app_radius.dart';

/// Meal verdict levels mapped to copy-deck keys verdict_1..3.
enum Verdict { balanced, acceptable, lighten }

class VerdictChip extends StatelessWidget {
  const VerdictChip({required this.verdict, this.onTap, super.key});
  final Verdict verdict;
  final VoidCallback? onTap;

  String _label(BuildContext context) {
    switch (verdict) {
      case Verdict.balanced:
        return context.translate(LangKeys.verdict1);
      case Verdict.acceptable:
        return context.translate(LangKeys.verdict2);
      case Verdict.lighten:
        return context.translate(LangKeys.verdict3);
    }
  }

  (Color, Color) _pair(ColorScheme scheme) {
    switch (verdict) {
      case Verdict.balanced:
        return (scheme.primaryContainer, scheme.onPrimaryContainer);
      case Verdict.acceptable:
        return (scheme.secondaryContainer, scheme.onSecondaryContainer);
      case Verdict.lighten:
        return (scheme.tertiaryContainer, scheme.onTertiaryContainer);
    }
  }

  IconData _icon() {
    switch (verdict) {
      case Verdict.balanced:
        return Icons.check_circle_outline;
      case Verdict.acceptable:
        return Icons.info_outline;
      case Verdict.lighten:
        return Icons.trending_down;
    }
  }

  @override
  Widget build(BuildContext context) {
    final (background, onBackground) = _pair(Theme.of(context).colorScheme);
    final borderRadius = BorderRadius.circular(AppRadius.small.r);
    final content = Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(_icon(), size: 16, color: onBackground),
          SizedBox(width: 4.w),
          TextApp(
            text: _label(context),
            theme: context.textStyle.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeightHelper.semiBold,
              color: onBackground,
            ),
          ),
        ],
      ),
    );
    if (onTap == null) {
      return Container(
        decoration: BoxDecoration(
          color: background,
          borderRadius: borderRadius,
        ),
        child: content,
      );
    }
    return Material(
      color: background,
      borderRadius: borderRadius,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48),
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: content,
        ),
      ),
    );
  }
}
