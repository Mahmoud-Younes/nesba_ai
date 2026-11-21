import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/features/review/logic/review_cubit.dart';

/// Day/week switch lifted to 48dp (spec §2.6); «اليوم» sits at the segment
/// start and mirrors with the locale automatically.
class SegmentedDayWeek extends StatelessWidget {
  const SegmentedDayWeek({
    required this.mode,
    required this.onChanged,
    super.key,
  });

  final ReviewMode mode;
  final ValueChanged<ReviewMode> onChanged;

  Widget _label(BuildContext context, String text, bool selected) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return TextApp(
      text: text,
      theme: context.textStyle.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.semiBold,
        color: selected ? scheme.onSecondaryContainer : scheme.onSurfaceVariant,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 48.h,
      child: SegmentedButton<ReviewMode>(
        expandedInsets: EdgeInsets.zero,
        showSelectedIcon: false,
        segments: <ButtonSegment<ReviewMode>>[
          ButtonSegment<ReviewMode>(
            value: ReviewMode.day,
            label: _label(
              context,
              context.translate(LangKeys.segmentDay),
              mode == ReviewMode.day,
            ),
          ),
          ButtonSegment<ReviewMode>(
            value: ReviewMode.week,
            label: _label(
              context,
              context.translate(LangKeys.segmentWeek),
              mode == ReviewMode.week,
            ),
          ),
        ],
        selected: <ReviewMode>{mode},
        onSelectionChanged: (Set<ReviewMode> selection) =>
            onChanged(selection.first),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(
            (Set<WidgetState> states) => states.contains(WidgetState.selected)
                ? scheme.secondaryContainer
                : scheme.surface,
          ),
          side: WidgetStatePropertyAll<BorderSide>(
            BorderSide(color: scheme.outline),
          ),
        ),
      ),
    );
  }
}
