import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

/// Macro summary grid — 3 columns (dot + label + «78 / 120 g» tabular);
/// collapses to one column when the text scaler reaches 1.6 (spec §1.5).
class MacroGrid extends StatelessWidget {
  const MacroGrid({
    required this.protein,
    required this.carbs,
    required this.fat,
    super.key,
  });

  /// Current vs target values per macro — western digits, passed pre-formatted.
  final ({String current, String target}) protein;
  final ({String current, String target}) carbs;
  final ({String current, String target}) fat;

  // LRI…PDI isolate keeps «78 / 120» LTR inside Arabic text (states §3.3).
  String _value(BuildContext context, ({String current, String target}) data) {
    final String unit = context.translate(LangKeys.unitGram);
    return '\u2066${data.current} / ${data.target}\u2069 $unit';
  }

  bool _singleColumn(BuildContext context) {
    final double scale = MediaQuery.textScalerOf(context).scale(14) / 14;
    return scale >= 1.6;
  }

  @override
  Widget build(BuildContext context) {
    if (_singleColumn(context)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _line(
            context,
            protein,
            LangKeys.macroProtein,
            context.color.chartProtein!,
          ),
          SizedBox(height: 12.h),
          _line(
            context,
            carbs,
            LangKeys.macroCarbs,
            context.color.chartCarbohydrate!,
          ),
          SizedBox(height: 12.h),
          _line(
            context,
            fat,
            LangKeys.macroFat,
            context.color.chartFat!,
          ),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _cell(
            context,
            data: protein,
            labelKey: LangKeys.macroProtein,
            dotColor: context.color.chartProtein!,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: _cell(
            context,
            data: carbs,
            labelKey: LangKeys.macroCarbs,
            dotColor: context.color.chartCarbohydrate!,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: _cell(
            context,
            data: fat,
            labelKey: LangKeys.macroFat,
            dotColor: context.color.chartFat!,
          ),
        ),
      ],
    );
  }

  // 3-column cell: dot + label on top, tabular «current / target unit» below.
  Widget _cell(
    BuildContext context, {
    required ({String current, String target}) data,
    required String labelKey,
    required Color dotColor,
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
          text: _value(context, data),
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

  // ≥1.6 line: dot + label at start, tabular value at end.
  Widget _line(
    BuildContext context,
    ({String current, String target}) data,
    String labelKey,
    Color dotColor,
  ) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Row(
      children: <Widget>[
        Container(
          width: 10.r,
          height: 10.r,
          decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.w),
        TextApp(
          text: context.translate(labelKey),
          theme: context.textStyle.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeightHelper.semiBold,
            color: scheme.onSurfaceVariant,
          ),
        ),
        const Spacer(),
        TextApp(
          text: _value(context, data),
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
