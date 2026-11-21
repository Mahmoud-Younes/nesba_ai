import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/animations/animate_do.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/features/onboarding/widgets/onboard_illustration.dart';

/// One onboarding page — illustration, title and body, all centered.
class OnboardPage extends StatelessWidget {
  const OnboardPage({
    required this.title,
    required this.body,
    required this.icon,
    super.key,
  });

  final String title;
  final String body;
  final IconData icon;

  // Skips the entrance when the OS asks for reduced motion.
  Widget _fadeIn(BuildContext context, int duration, Widget child) =>
      MediaQuery.disableAnimationsOf(context)
          ? child
          : CustomFadeInUp(duration: duration, child: child);

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Centered copy is accepted for onboarding (Arabic included).
          _fadeIn(context, 400, OnboardIllustration(icon: icon)),
          SizedBox(height: 32.h),
          _fadeIn(
            context,
            500,
            TextApp(
              text: title,
              textAlign: TextAlign.center,
              theme: context.textStyle.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeightHelper.semiBold,
                color: scheme.onSurface,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          _fadeIn(
            context,
            600,
            TextApp(
              text: body,
              textAlign: TextAlign.center,
              theme: context.textStyle.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeightHelper.regular,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
