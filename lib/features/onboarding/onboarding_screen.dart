import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/animations/animate_do.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/routes/app_routes.dart';
import 'package:nesba_ai/core/service/shared_pref/pref_keys.dart';
import 'package:nesba_ai/core/service/shared_pref/shared_pref.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/features/onboarding/widgets/onboard_page.dart';

/// Onboarding — three swiped pages, dots + skip/start pinned at the bottom.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const int _pageCount = 3;

  // viewportFraction 1 — no peeking neighbor pages.
  final PageController _controller = PageController(viewportFraction: 1);
  int _current = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isLast => _current == _pageCount - 1;

  // Marks first-run done, then lands on login (the flow is linear).
  Future<void> _finishOnboarding() async {
    await SharedPref().setBoolean(PrefKeys.onboardingDone, true);
    if (!mounted) return;
    context.pushReplacementNamed(AppRoutes.login);
  }

  // Skips the entrance when the OS asks for reduced motion.
  Widget _fadeIn(BuildContext context, int duration, Widget child) =>
      MediaQuery.disableAnimationsOf(context)
      ? child
      : CustomFadeInUp(duration: duration, child: child);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _pages(context)),
            _fadeIn(context, 700, _bottom(context)),
          ],
        ),
      ),
    );
  }

  // Swipe-only navigation — no programmatic page animation.
  Widget _pages(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemCount: _pageCount,
      onPageChanged: (int index) => setState(() => _current = index),
      itemBuilder: (BuildContext context, int index) {
        final (:icon, :title, :body) = _pageContent(context, index);
        return OnboardPage(icon: icon, title: title, body: body);
      },
    );
  }

  // Page copy — onboard_title_1..3 · onboard_body_1..3.
  ({IconData icon, String title, String body}) _pageContent(
    BuildContext context,
    int index,
  ) => switch (index) {
    0 => (
      icon: Icons.restaurant_menu,
      title: context.translate(LangKeys.onboardTitle1),
      body: context.translate(LangKeys.onboardBody1),
    ),
    1 => (
      icon: Icons.edit_note,
      title: context.translate(LangKeys.onboardTitle2),
      body: context.translate(LangKeys.onboardBody2),
    ),
    _ => (
      icon: Icons.donut_large,
      title: context.translate(LangKeys.onboardTitle3),
      body: context.translate(LangKeys.onboardBody3),
    ),
  };

  // Dots + actions under the pages.
  Widget _bottom(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _dots(context),
          SizedBox(height: 16.h),
          _actions(context),
        ],
      ),
    );
  }

  // Active dot paints primary, the rest outlineVariant.
  Widget _dots(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Duration duration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : const Duration(milliseconds: 250);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < _pageCount; i++)
          AnimatedContainer(
            duration: duration,
            width: 8.w,
            height: 8.w,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              color: i == _current ? scheme.primary : scheme.outlineVariant,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }

  // Skip shows only off the last page; both actions land on login.
  Widget _actions(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Duration duration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : const Duration(milliseconds: 250);
    return Row(
      children: [
        AnimatedSwitcher(
          duration: duration,
          child: _isLast
              ? const SizedBox.shrink(key: ValueKey<String>('onboard-no-skip'))
              : TextButton(
                  key: const ValueKey<String>('onboard-skip'),
                  onPressed: _finishOnboarding,
                  style: TextButton.styleFrom(minimumSize: Size(64.w, 48.h)),
                  child: TextApp(
                    text: context.translate(LangKeys.onboardSkip),
                    theme: context.textStyle.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeightHelper.medium,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: SizedBox(
            height: 48.h,
            child: FilledButton(
              onPressed: _finishOnboarding,
              style: FilledButton.styleFrom(shape: const StadiumBorder()),
              child: TextApp(
                text: context.translate(LangKeys.onboardCta),
                theme: context.textStyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeightHelper.medium,
                  color: scheme.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
