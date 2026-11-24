import 'package:flutter/material.dart';

import 'screens/onboarding_screen.dart';
import 'theme/bustan_theme.dart';

void main() {
  runApp(const OnboardingPreviewApp());
}

class OnboardingPreviewApp extends StatelessWidget {
  const OnboardingPreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding preview',
      debugShowCheckedModeBanner: false,
      theme: BustanTheme.light(),
      home: const OnboardingScreen(),
    );
  }
}
