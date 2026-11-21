import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/core/widgets/chips/edited_chip.dart';

/// Breakdown item row: name + quantity + tabular kcal + end chevron;
/// variants lowConfidence (note line + icon) and edited (EditedChip)
/// (spec §1.5 ItemRow).
class ItemRow extends StatelessWidget {
  const ItemRow({
    required this.name,
    required this.amountText,
    required this.kcalText,
    this.lowConfidence = false,
    this.edited = false,
    this.onTap,
    super.key,
  });

  final String name;

  /// Pre-formatted quantity line — western digits inside isolated paths.
  final String amountText;

  /// Pre-formatted kcal value — western digits, rendered tabular.
  final String kcalText;

  /// Renders the localized low-confidence note line with an icon.
  final bool lowConfidence;

  /// Renders the localized «edited» mini chip next to the name.
  final bool edited;

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
      constraints: BoxConstraints(minHeight: 56.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: TextApp(
                        text: name,
                        theme: context.textStyle.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeightHelper.semiBold,
                          color: scheme.onSurface,
                        ),
                      ),
                    ),
                    if (edited) ...<Widget>[
                      SizedBox(width: 8.w),
                      const EditedChip(),
                    ],
                  ],
                ),
                SizedBox(height: 2.h),
                TextApp(
                  text: amountText,
                  theme: context.textStyle.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeightHelper.regular,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                if (lowConfidence) ...<Widget>[
                  SizedBox(height: 4.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.info_outline,
                        size: 16.r,
                        color: scheme.onSurfaceVariant,
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: TextApp(
                          text: context.translate(LangKeys.lowConfidenceNote),
                          theme: context.textStyle.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeightHelper.regular,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
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
          SizedBox(width: 8.w),
          Icon(_chevron(context), size: 24.r, color: scheme.onSurfaceVariant),
        ],
      ),
    );
    if (onTap == null) {
      return row;
    }
    return InkWell(onTap: onTap, child: row);
  }
}
