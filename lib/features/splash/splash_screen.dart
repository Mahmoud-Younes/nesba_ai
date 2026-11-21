import 'package:flutter/material.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/routes/app_routes.dart';
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

  // Routes next: onboarding on first run, the home shell afterwards.
  void _goNext() {
    if (!mounted) return;
    final bool done = SharedPref().getBoolean(PrefKeys.onboardingDone) ?? false;
    if (done) {
      context.pushReplacementNamed(AppRoutes.home);
    } else {
      context.pushReplacementNamed(AppRoutes.onboarding);
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
