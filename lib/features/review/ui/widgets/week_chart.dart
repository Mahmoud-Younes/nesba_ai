import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/helpers/format_helpers.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/features/review/data/models/week_summary.dart';

/// S07 chart card — seven bars, oldest at the far left in both locales,
/// under/over-goal color plus a blank slot for a day with no data.
class WeekChart extends StatelessWidget {
  const WeekChart({required this.days, required this.goal, super.key});

  final List<WeekDay> days;
  final int goal;

  static const double _barArea = 120;

  int get _maxKcal => days.fold<int>(
        goal > 0 ? goal : 1,
        (int max, WeekDay day) => day.kcal != null && day.kcal! > max
            ? day.kcal!
            : max,
      );

  bool get _hasGoal => goal > 0;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextApp(
            text: context.translate(LangKeys.weekChartTitle),
            theme: context.textStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeightHelper.semiBold,
              color: scheme.onSurface,
            ),
          ),
          SizedBox(height: 16.h),
          Semantics(
            label: _a11yLabel(context),
            child: ExcludeSemantics(
              child: _chart(context),
            ),
          ),
        ],
      ),
    );
  }

  // The time axis never mirrors: oldest left, newest right in AR and EN.
  Widget _chart(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool showEveryOther = _largeText(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: _barArea.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                for (final WeekDay day in days)
                  Expanded(child: _bar(context, day)),
              ],
            ),
          ),
          Container(height: 1, color: scheme.outlineVariant),
          SizedBox(height: 8.h),
          Row(
            children: <Widget>[
              for (int i = 0; i < days.length; i++)
                Expanded(
                  child: TextApp(
                    text: showEveryOther && i.isOdd
                        ? ''
                        : _dayLabel(context, days[i].date),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    theme: context.textStyle.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeightHelper.regular,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bar(BuildContext context, WeekDay day) {
    if (!day.hasData) {
      // No data is not zero — the slot stays visibly empty.
      return const SizedBox.shrink();
    }
    final bool over = _hasGoal && day.kcal! > goal;
    final Color color = _hasGoal
        ? (over ? context.color.chartOverTarget! : context.color.chartUnderTarget!)
        : Theme.of(context).colorScheme.primary;
    final double fraction = (day.kcal! / _maxKcal).clamp(0.0, 1.0);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 18.w,
        height: fraction <= 0 ? 3.h : (_barArea * fraction).h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.vertical(top: Radius.circular(6.r)),
        ),
      ),
    );
  }

  String _dayLabel(BuildContext context, DateTime date) =>
      DateFormat.E(Localizations.localeOf(context).toLanguageTag())
          .format(date);

  bool _largeText(BuildContext context) =>
      MediaQuery.textScalerOf(context).scale(10) >= 15;

  // Full spoken summary, read in the same oldest-to-newest order as the axis.
  String _a11yLabel(BuildContext context) {
    final DateFormat format =
        DateFormat.E(Localizations.localeOf(context).toLanguageTag());
    final String goalSuffix = _hasGoal
        ? ' ${context.translate(LangKeys.ringGoalSuffix).replaceAll('{value}', formatCalories(goal))}'
        : '';
    final List<String> parts = <String>[
      for (final WeekDay day in days) _dayPart(context, format, day, goalSuffix),
    ];
    final String daysText = parts.join('. ');
    return '${context.translate(LangKeys.chartA11ySummary).replaceAll('{days}', daysText)}.';
  }

  String _dayPart(
    BuildContext context,
    DateFormat format,
    WeekDay day,
    String goalSuffix,
  ) {
    final String name = format.format(day.date);
    if (!day.hasData) return '$name —';
    final String kcal = '\u2066${formatCalories(day.kcal!)}\u2069';
    final String base = '$name $kcal$goalSuffix';
    if (!_hasGoal || day.kcal! <= goal) return base;
    final String over = context
        .translate(LangKeys.overGoalLabel)
        .replaceAll('{value}', formatCalories(day.kcal! - goal));
    return '$base. $over';
  }
}
