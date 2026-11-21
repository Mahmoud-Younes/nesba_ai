import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

/// Top-of-card stale notice (G-02) — keep action rides the deck key.
class StaleGuardNotice extends StatelessWidget {
  const StaleGuardNotice({this.onReanalyze, this.onKeep, super.key});

  final VoidCallback? onReanalyze;
  final VoidCallback? onKeep;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(12.w, 4.h, 12.w, 4.h),
      decoration: BoxDecoration(
        color: scheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextApp(
            text: context.translate(LangKeys.staleGuardNotice),
            textAlign: TextAlign.start,
            theme: context.textStyle.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeightHelper.regular,
              color: scheme.onTertiaryContainer,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _action(
                context,
                context.translate(LangKeys.reAnalyze),
                onReanalyze,
              ),
              if (onKeep != null) ...[
                SizedBox(width: 8.w),
                _action(
                  context,
                  context.translate(LangKeys.staleKeepAction),
                  onKeep,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _action(BuildContext context, String label, VoidCallback? onPressed) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: scheme.onTertiaryContainer,
        minimumSize: const Size(48, 48),
        padding: EdgeInsets.symmetric(horizontal: 8.w),
      ),
      child: TextApp(
        text: label,
        theme: context.textStyle.copyWith(
          fontSize: 12.sp,
          fontWeight: FontWeightHelper.semiBold,
          color: scheme.onTertiaryContainer,
        ),
      ),
    );
  }
}
