import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/animations/animate_do.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

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

  // Name on primary, tagline under it on onSurfaceVariant.
  Widget _mark(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextApp(
          text: context.translate(LangKeys.appName),
          theme: context.textStyle.copyWith(
            fontSize: 36.sp,
            fontWeight: FontWeightHelper.semiBold,
            color: scheme.primary,
          ),
        ),
        SizedBox(height: 12.h),
        TextApp(
          text: context.translate(LangKeys.splashTagline),
          textAlign: TextAlign.center,
          theme: context.textStyle.copyWith(
            fontSize: 14.sp,
            color: scheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
