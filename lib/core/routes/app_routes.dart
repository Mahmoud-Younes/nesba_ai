import 'package:flutter/material.dart';
import 'package:nesba_ai/core/common/screens/under_build_screen.dart';
import 'package:nesba_ai/core/routes/base_routes.dart';
import 'package:nesba_ai/features/home/ui/home_screen.dart';
import 'package:nesba_ai/features/login/ui/login_screen.dart';
import 'package:nesba_ai/features/onboarding/onboarding_screen.dart';
import 'package:nesba_ai/features/settings/ui/settings_screen.dart';
import 'package:nesba_ai/features/sign_up/ui/sign_up_screen.dart';
import 'package:nesba_ai/features/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = 'splash';
  static const String onboarding = 'onboarding';
  static const String login = 'login';
  static const String signUp = 'signUp';
  static const String home = 'home';
  static const String settings = 'settings';

  static Route<void> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoutes.splash:
        return BaseRoute(page: const SplashScreen());
      case AppRoutes.onboarding:
        return BaseRoute(page: const OnboardingScreen());
      case AppRoutes.login:
        return BaseRoute(page: const LoginScreen());
      case AppRoutes.signUp:
        return BaseRoute(page: const SignUpScreen());
      case AppRoutes.home:
        return BaseRoute(page: const HomeScreen());
      case AppRoutes.settings:
        return BaseRoute(page: const SettingsScreen());

      default:
        return BaseRoute(page: const PageUnderBuildScreen());
    }
  }
}
