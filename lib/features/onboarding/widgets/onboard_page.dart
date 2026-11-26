import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/animations/animate_do.dart';
import 'package:nesba_ai/core/helpers/spacing.dart';
import 'package:nesba_ai/core/widgets/nes_page_header.dart';
import 'package:nesba_ai/core/widgets/nes_screen_body.dart';
import 'package:nesba_ai/features/onboarding/widgets/onboard_illustration.dart';

/// One onboarding page — illustration over the centred title and body.
///
/// The text block is [NesPageHeader], so the first screen a user ever sees
/// is set in the same type as the sign-in screen that follows it.
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
    // 200% accommodation (states §5.2): the page scrolls and the
    // illustration steps aside once text scale crosses 1.6.
    final bool largeText =
        MediaQuery.textScalerOf(context).scale(14) >= 1.6 * 14;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenEdge.w),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: NesScreenBody.maxContentWidth.w,
                ),
                child: _pageColumn(context, showIllustration: !largeText),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _pageColumn(BuildContext context, {required bool showIllustration}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (showIllustration) ...<Widget>[
          _fadeIn(context, 400, OnboardIllustration(icon: icon)),
          verticalSpace(AppSpacing.s32),
        ],
        _fadeIn(
          context,
          500,
          NesPageHeader(title: title, subtitle: body, centered: true),
        ),
      ],
    );
  }
}
