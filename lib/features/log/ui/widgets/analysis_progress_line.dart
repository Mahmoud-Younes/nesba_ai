import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

/// Rotating progress line (screen-specs §2.2): step 1..3 picks the copy;
/// instant swap, no crossfade, when animations are disabled.
class AnalysisProgressLine extends StatelessWidget {
  const AnalysisProgressLine({required this.progressStep, super.key})
    : assert(progressStep >= 1 && progressStep <= 3, 'progressStep is 1..3');

  /// Current rotation step; the screen drives the ≈2.5s cadence.
  final int progressStep;

  String _copyFor(BuildContext context) {
    return switch (progressStep) {
      1 => context.translate(LangKeys.analysisProgress1),
      2 => context.translate(LangKeys.analysisProgress2),
      _ => context.translate(LangKeys.analysisProgress3),
    };
  }

  @override
  Widget build(BuildContext context) {
    final bool reduceMotion = MediaQuery.disableAnimationsOf(context);
    return AnimatedSwitcher(
      duration: reduceMotion ? Duration.zero : const Duration(milliseconds: 300),
      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
        return Stack(
          alignment: AlignmentDirectional.centerStart,
          children: <Widget>[
            ...previousChildren,
            ?currentChild,
          ],
        );
      },
      child: KeyedSubtree(
        key: ValueKey<int>(progressStep),
        child: TextApp(
          text: _copyFor(context),
          theme: context.textStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeightHelper.regular,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
