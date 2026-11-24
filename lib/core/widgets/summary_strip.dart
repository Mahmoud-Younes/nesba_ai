import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/core/widgets/calorie_ring.dart';

/// Daily summary strip — 48dp, mini CalorieRing + tabular count line
/// (spec §2.0-A). The hosting screen supplies the 16dp page margin.
/// Goal present → «1,240 / 2,000 · status»; otherwise the deck noGoal copy.
class SummaryStrip extends StatelessWidget {
  const SummaryStrip({
    required this.consumed,
    required this.goal,
    required this.semanticsLabel,
    this.statusText,
    this.onTap,
    super.key,
  });

  final int consumed;

  /// null or ≤ 0 renders the noGoal variant.
  final int? goal;

  /// Trailing copy after the «·» separator («فاضل 760»); the numbers path
  /// renders alone when null.
  final String? statusText;

  /// Whole-strip a11y summary («السعرات: 1,240 من 2,000» + الحالة).
  final String semanticsLabel;

  final VoidCallback? onTap;

  bool get _hasGoal => goal != null && goal! > 0;

  // «1,240 / 2,000 · status» — numeric path LRI…PDI isolated (states §3.3).
  String _line(BuildContext context) {
    if (!_hasGoal) {
      return context.translate(LangKeys.noGoal);
    }
    final String numbers =
        '\u2066${formatCalories(consumed)} / ${formatCalories(goal!)}\u2069';
    if (statusText == null) {
      return numbers;
    }
    return '$numbers · $statusText';
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Widget row = ConstrainedBox(
      constraints: BoxConstraints(minHeight: 48.h),
      child: Row(
        children: <Widget>[
          CalorieRing(
            variant: CalorieRingVariant.mini,
            consumed: consumed,
            goal: goal,
            semanticsLabel: semanticsLabel,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextApp(
              text: _line(context),
              theme: context.textStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeightHelper.regular,
                fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
                color: scheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
    return Semantics(
      label: semanticsLabel,
      button: onTap != null,
      excludeSemantics: true,
      child: onTap == null
          ? row
          : Material(
              color: Colors.transparent,
              child: InkWell(onTap: onTap, child: row),
            ),
    );
  }
}
