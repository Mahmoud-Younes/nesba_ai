import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

/// CTA states (screen-specs §1.5): enabled / disabled(reason) / progress.
enum AnalyzeCtaStatus { enabled, disabled, progress }

/// Analyze CTA — full-width 48dp filled button with visible-state variants.
class AnalyzeCTA extends StatelessWidget {
  const AnalyzeCTA({
    required this.status,
    this.progressText = '',
    this.onAnalyze,
    this.onCancel,
    super.key,
  });

  final AnalyzeCtaStatus status;

  /// Rotating line (screen passes analysis_progress_1..3 per step, ≈2.5s).
  final String progressText;
  final VoidCallback? onAnalyze;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return switch (status) {
      AnalyzeCtaStatus.enabled => _filledButton(context, scheme),
      AnalyzeCtaStatus.disabled => _disabledWithReason(context, scheme),
      AnalyzeCtaStatus.progress => _progressRow(context, scheme),
    };
  }

  Widget _filledButton(BuildContext context, ColorScheme scheme) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: FilledButton(
        onPressed: onAnalyze,
        child: TextApp(
          text: context.translate(LangKeys.logAnalyzeCta),
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
          theme: context.textStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeightHelper.medium,
            color: scheme.onPrimary,
          ),
        ),
      ),
    );
  }

  // Disabled is never silent: the reason sits under the button (states §1.2-1).
  Widget _disabledWithReason(BuildContext context, ColorScheme scheme) {
    return MergeSemantics(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: FilledButton(
              onPressed: null,
              child: TextApp(
                text: context.translate(LangKeys.logAnalyzeCta),
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
                theme: context.textStyle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeightHelper.medium,
                  color: scheme.onSurface.withValues(alpha: 0.38),
                ),
              ),
            ),
          ),
          SizedBox(height: 4.h),
          TextApp(
            text: context.translate(LangKeys.logCtaDisabled),
            maxLines: 2,
            theme: context.textStyle.copyWith(
              fontSize: 12.sp,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  // In-place progress: 20dp M3 inline indicator + rotating line + cancel ≥48dp.
  Widget _progressRow(BuildContext context, ColorScheme scheme) {
    return SizedBox(
      height: 48.h,
      child: Row(
        children: [
          SizedBox(
            width: 20.r,
            height: 20.r,
            child: CircularProgressIndicator(
              strokeWidth: 2.5.r,
              color: scheme.primary,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextApp(
              text: progressText,
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
              theme: context.textStyle.copyWith(
                fontSize: 14.sp,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
          TextButton(
            onPressed: onCancel,
            style: TextButton.styleFrom(
              minimumSize: Size(64, 48.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
            ),
            child: TextApp(
              text: context.translate(LangKeys.analysisCancel),
              maxLines: 1,
              theme: context.textStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeightHelper.medium,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
