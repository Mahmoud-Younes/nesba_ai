import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

/// Footnote line (screen-specs §2.2): silent before 3s, timing note from 3s,
/// G-01 slow note with schedule icon from 8s.
class AnalysisFootnoteLine extends StatelessWidget {
  const AnalysisFootnoteLine({required this.elapsedSeconds, super.key});

  /// Elapsed analysis time in wall-clock seconds (screen drives the clock).
  final int elapsedSeconds;

  // Switcher key phases: 0 silent, 1 timing note, 2 slow note.
  int get _phase {
    if (elapsedSeconds >= 8) return 2;
    if (elapsedSeconds >= 3) return 1;
    return 0;
  }

  TextStyle _noteStyle(BuildContext context) {
    return context.textStyle.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeightHelper.regular,
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );
  }

  Widget _child(BuildContext context) {
    return switch (_phase) {
      1 => TextApp(
          text: context.translate(LangKeys.analysisFootnote),
          theme: _noteStyle(context),
        ),
      2 => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.schedule,
              size: 14.r,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: TextApp(
                text: context.translate(LangKeys.analysisSlowNote),
                theme: _noteStyle(context),
              ),
            ),
          ],
        ),
      _ => const SizedBox.shrink(),
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
        key: ValueKey<int>(_phase),
        child: _child(context),
      ),
    );
  }
}
