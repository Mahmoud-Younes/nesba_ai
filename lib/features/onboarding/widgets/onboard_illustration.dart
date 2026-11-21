import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/style/theme/app_radius.dart';

/// Onboarding illustration placeholder — ~220dp rounded panel with a big icon.
class OnboardIllustration extends StatelessWidget {
  const OnboardIllustration({required this.icon, super.key});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      height: 220.h,
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppRadius.extraLarge.r),
      ),
      // TODO(figma): replace the placeholder icon with the real assets.
      child: Icon(icon, size: 72.r, color: scheme.onPrimaryContainer),
    );
  }
}
