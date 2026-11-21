import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

/// Portion stepper (spec §2.4): − / + 48dp icon buttons around a tabular
/// «×N» value; minus sits on the start edge (mirrors automatically in RTL).
class QtyStepper extends StatelessWidget {
  const QtyStepper({
    required this.value,
    this.onMinus,
    this.onPlus,
    super.key,
  });

  /// Current portion multiplier, rendered as «×1.5» between the buttons.
  final double value;
  final VoidCallback? onMinus;
  final VoidCallback? onPlus;

  // Deck multiplier set {×0.5, ×1, ×1.5, ×2} — drop a trailing «.0».
  String _label() {
    final String fixed = value.toStringAsFixed(1);
    final String digits =
        fixed.endsWith('.0') ? fixed.substring(0, fixed.length - 2) : fixed;
    return '×$digits';
  }

  // The deck ships one combined pair «زيادة الحصة / إنقاصها» — split on the
  // deck separator; both buttons fall back to the full string if unsplit.
  List<String> _semanticsParts(BuildContext context) =>
      context.translate(LangKeys.stepperSemantics).split(' / ');

  // 48dp touch target via constraints (states §3.1); Semantics covers a11y.
  Widget _button(
    BuildContext context,
    IconData icon,
    String semantics,
    VoidCallback? onPressed,
  ) {
    return Semantics(
      label: semantics,
      button: true,
      child: IconButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(minWidth: 48.w, minHeight: 48.h),
        icon: Icon(icon, size: 24.r),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> parts = _semanticsParts(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _button(
          context,
          Icons.remove_outlined,
          parts.length > 1 ? parts.last : parts.first,
          onMinus,
        ),
        SizedBox(width: 8.w),
        // Fixed minimum width keeps the value from shifting the buttons.
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 48.w),
          child: TextApp(
            text: _label(),
            textAlign: TextAlign.center,
            theme: context.textStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeightHelper.semiBold,
              fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
            ),
          ),
        ),
        SizedBox(width: 8.w),
        _button(context, Icons.add_outlined, parts.first, onPlus),
      ],
    );
  }
}
