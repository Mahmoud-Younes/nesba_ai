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
    // 200% accommodation (states §5.2): the page scrolls and the
    // illustration steps aside once text scale crosses 1.6.
    final bool largeText =
        MediaQuery.textScalerOf(context).scale(14) >= 1.6 * 14;
    final Widget page = _pageColumn(context, scheme, showIllustration: !largeText);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(child: page),
          ),
        );
      },
    );
  }

  Widget _pageColumn(
    BuildContext context,
    ColorScheme scheme, {
    required bool showIllustration,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showIllustration) ...<Widget>[
          _fadeIn(context, 400, OnboardIllustration(icon: icon)),
          SizedBox(height: 32.h),
        ],
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
      );
  }
}
