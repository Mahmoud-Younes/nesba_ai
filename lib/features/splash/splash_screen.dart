import 'package:flutter/material.dart';
import 'package:nesba_ai/core/service/shared_pref/pref_keys.dart';
import 'package:nesba_ai/core/service/shared_pref/shared_pref.dart';
import 'package:nesba_ai/features/splash/ui/widgets/splash_wordmark.dart';

/// Splash — wordmark fades in, then routes on after a short hold.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const Duration _hold = Duration(milliseconds: 1200);

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(_hold, _goNext);
  }

  // Routes next: onboarding on first run, review/log gate afterwards.
  Future<void> _goNext() async {
    if (!mounted) return;
    final bool done = SharedPref().getBoolean(PrefKeys.onboardingDone) ?? false;
    if (done) {
      // TODO(route): returning user → review/log gate, not registered yet.
      // Intended: context.pushReplacementNamed(AppRoutes.review);
    } else {
      // TODO(route): first run → onboarding, not registered yet.
      // Intended: context.pushReplacementNamed(AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: const Center(child: SplashWordmark()),
    );
  }
}
