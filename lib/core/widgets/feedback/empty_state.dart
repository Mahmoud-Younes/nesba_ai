import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

/// Empty-state anatomy: illustration placeholder + title + body + single CTA
/// (deck §2.6, neutral tone — no blame).
class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.title,
    required this.body,
    required this.ctaLabel,
    this.onCta,
    super.key,
  });

  final String title;
  final String body;
  final String ctaLabel;
  final VoidCallback? onCta;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // TODO(assets): replace placeholder with the real illustration asset.
        Container(
          width: 120.w,
          height: 120.h,
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        SizedBox(height: 16.h),
        TextApp(
          text: title,
          textAlign: TextAlign.start,
          theme: context.textStyle.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeightHelper.semiBold,
            color: scheme.onSurface,
          ),
        ),
        SizedBox(height: 8.h),
        TextApp(
          text: body,
          textAlign: TextAlign.start,
          theme: context.textStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeightHelper.regular,
            color: scheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 16.h),
        FilledButton(
          onPressed: onCta,
          style: FilledButton.styleFrom(
            backgroundColor: scheme.primary,
            foregroundColor: scheme.onPrimary,
            minimumSize: Size(48.w, 48.h),
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            shape: const StadiumBorder(),
          ),
          child: TextApp(
            text: ctaLabel,
            theme: context.textStyle.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeightHelper.semiBold,
              color: scheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
