import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

/// Single macros line — 3 items: 10dp chart-colored dot + macro_* label +
/// tabular value on onSurface, color never used as text signal (spec §1.5).
class MacroRow extends StatelessWidget {
  const MacroRow({
    required this.proteinText,
    required this.carbsText,
    required this.fatText,
    super.key,
  });

  /// Pre-formatted values — western digits, rendered tabular.
  final String proteinText;
  final String carbsText;
  final String fatText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _item(
            context,
            dotColor: context.color.chartProtein!,
            labelKey: LangKeys.macroProtein,
            value: proteinText,
          ),
        ),
        Expanded(
          child: _item(
            context,
            dotColor: context.color.chartCarbohydrate!,
            labelKey: LangKeys.macroCarbs,
            value: carbsText,
          ),
        ),
        Expanded(
          child: _item(
            context,
            dotColor: context.color.chartFat!,
            labelKey: LangKeys.macroFat,
            value: fatText,
          ),
        ),
      ],
    );
  }

  Widget _item(
    BuildContext context, {
    required Color dotColor,
    required String labelKey,
    required String value,
  }) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 10.r,
              height: 10.r,
              decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
            ),
            SizedBox(width: 6.w),
            Flexible(
              child: TextApp(
                text: context.translate(labelKey),
                theme: context.textStyle.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeightHelper.semiBold,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        TextApp(
          text: value,
          theme: context.textStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeightHelper.regular,
            fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
            color: scheme.onSurface,
          ),
        ),
      ],
    );
  }
}
