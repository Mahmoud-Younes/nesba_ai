import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/animations/animate_do.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/helpers/spacing.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/app_type_scale.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/core/widgets/nes_screen_body.dart';

/// Splash wordmark — «نِسْبَة» over the tagline, one fade-in entrance.
class SplashWordmark extends StatelessWidget {
  const SplashWordmark({super.key});

  @override
  Widget build(BuildContext context) {
    // Reduced motion → straight in, no entrance animation.
    return MediaQuery.disableAnimationsOf(context)
        ? _mark(context)
        : CustomFadeInUp(duration: 600, child: _mark(context));
  }

  // Name on primary, tagline under it on onSurfaceVariant — the same
  // lead-line treatment every other screen gives its subtitle.
  Widget _mark(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenEdge.w),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: NesScreenBody.maxContentWidth.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextApp(
              text: context.translate(LangKeys.appName),
              theme: context.textStyle.copyWith(
                fontSize: AppTypeScale.displaySmall.sp,
                fontWeight: FontWeightHelper.semiBold,
                color: scheme.primary,
              ),
            ),
            verticalSpace(AppSpacing.s12),
            TextApp(
              text: context.translate(LangKeys.splashTagline),
              textAlign: TextAlign.center,
              theme: context.textStyle.copyWith(
                fontSize: AppTypeScale.bodyLarge.sp,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
