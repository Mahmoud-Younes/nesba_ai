import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/core/widgets/rows/ledger_row.dart';

/// Review list row: LedgerRow structure + optional badge slot and a
/// direction-aware end chevron (spec §1.5 MealRow).
class MealRow extends StatelessWidget {
  const MealRow({
    required this.name,
    required this.mealType,
    required this.timeText,
    required this.kcalText,
    this.badge,
    this.semanticsLabel,
    this.onTap,
    super.key,
  });

  final String name;
  final MealType mealType;
  final String timeText;

  /// Pre-formatted kcal value — western digits, rendered tabular.
  final String kcalText;

  /// Optional trailing badge (e.g. sync badge) — passed ready-built by the caller.
  final Widget? badge;

  /// Whole-row a11y summary; null keeps the default text traversal.
  final String? semanticsLabel;

  final VoidCallback? onTap;

  // Chevron is mirrored manually — chevron_right never flips alone (spec §5 RTL).
  IconData _chevron(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    return isRtl ? Icons.chevron_left : Icons.chevron_right;
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Widget row = ConstrainedBox(
      constraints: BoxConstraints(minHeight: 64.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            mealTypeIcon(mealType),
            size: 24.r,
            color: scheme.onSurfaceVariant,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextApp(
                  text: name,
                  theme: context.textStyle.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeightHelper.semiBold,
                    color: scheme.onSurface,
                  ),
                ),
                SizedBox(height: 2.h),
                TextApp(
                  text: mealSubLine(context, mealType, timeText),
                  theme: context.textStyle.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeightHelper.regular,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          TextApp(
            text: kcalText,
            theme: context.textStyle.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeightHelper.regular,
              fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
              color: scheme.onSurface,
            ),
          ),
          if (badge != null) ...<Widget>[
            SizedBox(width: 8.w),
            badge!,
          ],
          // Navigation affordance only on tappable rows.
          if (onTap != null) ...<Widget>[
            SizedBox(width: 8.w),
            Icon(_chevron(context), size: 24.r, color: scheme.onSurfaceVariant),
          ],
        ],
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Semantics(
          label: semanticsLabel,
          button: onTap != null,
          excludeSemantics: true,
          child: onTap != null ? InkWell(onTap: onTap, child: row) : row,
        ),
        SizedBox(height: 12.h),
        Divider(height: 1, thickness: 1, color: scheme.outlineVariant),
      ],
    );
  }
}
