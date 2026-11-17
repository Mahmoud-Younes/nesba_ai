import 'package:flutter/material.dart';
import 'package:nesba_ai/core/common/screens/under_build_screen.dart';
import 'package:nesba_ai/core/routes/base_routes.dart';
import 'package:nesba_ai/features/page_one/ui/page_one_screen.dart';
import 'package:nesba_ai/features/page_three/ui/page_three_screen.dart';
import 'package:nesba_ai/features/page_two/ui/page_two_screen.dart';

class AppRoutes {
  static const String testHome = 'testHome';
  static const String pageTwo = 'pageTwo';
  static const String pageThree = 'pageThree';

  static Route<void> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case testHome:
        return BaseRoute(page: const PageOneScreen());
      case pageTwo:
        return BaseRoute(page: const PageTwoScreen());
      case pageThree:
        return BaseRoute(page: const PageThreeScreen());

      default:
        return BaseRoute(page: const PageUnderBuildScreen());
    }
  }
}
