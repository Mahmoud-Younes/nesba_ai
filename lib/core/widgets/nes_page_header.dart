import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/helpers/spacing.dart';
import 'package:nesba_ai/core/style/fonts/app_type_scale.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

/// Page header: optional uppercase eyebrow, the title, and a lead line.
///
/// One widget so every gate opens the same way — the title says where you
/// are and the subtitle says what the screen is for, before any control.
/// Nothing here is clipped or line-capped: at 200% text scale the block
/// grows and the page scrolls (states §5.2).
class NesPageHeader extends StatelessWidget {
  const NesPageHeader({
    required this.title,
    this.eyebrow,
    this.subtitle,
    this.centered = false,
    super.key,
  });

  final String title;

  /// Small primary-tinted line above the title — the auth screens use it
  /// ("WELCOME BACK"); the gates leave it off.
  final String? eyebrow;

  final String? subtitle;

  /// Auth screens centre the block; the gates keep it start-aligned.
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final TextAlign? align = centered ? TextAlign.center : null;

    return Column(
      crossAxisAlignment: centered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (eyebrow case final String text) ...<Widget>[
          TextApp(
            text: text.toUpperCase(),
            textAlign: align,
            theme: context.textStyle.copyWith(
              fontSize: AppTypeScale.labelLarge.sp,
              fontWeight: FontWeightHelper.semiBold,
              color: scheme.primary,
              letterSpacing: AppTypeScale.eyebrowTracking,
            ),
          ),
          verticalSpace(AppSpacing.s8),
        ],
        TextApp(
          text: title,
          textAlign: align,
          theme: context.textStyle.copyWith(
            fontSize: AppTypeScale.headlineMedium.sp,
            fontWeight: FontWeightHelper.semiBold,
            color: scheme.onSurface,
          ),
        ),
        if (subtitle case final String text) ...<Widget>[
          verticalSpace(AppSpacing.s8),
          TextApp(
            text: text,
            textAlign: align,
            theme: context.textStyle.copyWith(
              fontSize: AppTypeScale.bodyLarge.sp,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}
