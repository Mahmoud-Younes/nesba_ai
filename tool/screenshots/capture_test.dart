@Tags(<String>['screenshots'])
library;

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/core/di/injection_container.dart';
import 'package:nesba_ai/features/log/logic/log_cubit.dart';
import 'package:nesba_ai/features/log/ui/log_screen.dart';
import 'package:nesba_ai/features/login/ui/login_screen.dart';
import 'package:nesba_ai/features/onboarding/onboarding_screen.dart';
import 'package:nesba_ai/features/review/logic/review_cubit.dart';
import 'package:nesba_ai/features/review/ui/review_screen.dart';
import 'package:nesba_ai/features/sign_up/ui/sign_up_screen.dart';
import 'package:nesba_ai/features/splash/ui/widgets/splash_wordmark.dart';

import '../../test/helpers/pump_app.dart';

/// Renders each screen off-device and writes one PNG per state.
///
/// Not a test — nothing is asserted. It lives outside `test/` so
/// `flutter test` never collects it, and it exists because reviewing a
/// restyle means looking at the screen. It drives the real widgets through
/// the production theme and the real `lang/*.json`, so what lands here is
/// what the app draws; it needs no Gradle, which matters while the Android
/// build is blocked on this machine.
///
/// Run (SHOT_DIR must be an absolute directory):
///
///     flutter test tool/screenshots/capture_test.dart \
///       --dart-define=SHOT_DIR=C:/path/to/out
const String _outputDir = String.fromEnvironment('SHOT_DIR');

/// 2x so the PNG stays legible when opened at 100%.
const double _pixelRatio = 2;

final GlobalKey _shotKey = GlobalKey();

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    if (_outputDir.isEmpty) {
      fail('Pass --dart-define=SHOT_DIR=... with an absolute directory.');
    }
    await _loadProjectFonts();
    Directory(_outputDir).createSync(recursive: true);
  });

  setUp(() async {
    await sl.reset();
    await setupInjector();
  });

  group('auth', () {
    testWidgets('sign in, empty, english', (WidgetTester tester) async {
      await _pump(tester, const LoginScreen(), locale: const Locale('en'));
      await _save(tester, '01-sign-in-en');
    });

    testWidgets('sign in, empty, arabic', (WidgetTester tester) async {
      await _pump(tester, const LoginScreen(), locale: const Locale('ar'));
      await _save(tester, '02-sign-in-ar');
    });

    testWidgets('sign in, validation errors', (WidgetTester tester) async {
      await _pump(tester, const LoginScreen(), locale: const Locale('en'));
      await tester.enterText(find.byType(TextField).first, 'not-an-email');
      await tester.enterText(find.byType(TextField).last, '123');
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();
      await _save(tester, '03-sign-in-validation-en');
    });

    testWidgets('sign in, arabic at 200% text scale', (
      WidgetTester tester,
    ) async {
      await _pump(
        tester,
        const LoginScreen(),
        locale: const Locale('ar'),
        textScaler: const TextScaler.linear(2),
      );
      await _save(tester, '04-sign-in-ar-200pc');
    });

    testWidgets('create account, empty, english', (WidgetTester tester) async {
      await _pump(tester, const SignUpScreen(), locale: const Locale('en'));
      await _save(tester, '05-create-account-en');
    });

    testWidgets('create account, empty, arabic', (WidgetTester tester) async {
      await _pump(tester, const SignUpScreen(), locale: const Locale('ar'));
      await _save(tester, '06-create-account-ar');
    });
  });

  group('first run', () {
    testWidgets('splash, english', (WidgetTester tester) async {
      await _pump(
        tester,
        const Center(child: SplashWordmark()),
        locale: const Locale('en'),
      );
      await _save(tester, '07-splash-en');
    });

    testWidgets('splash, arabic', (WidgetTester tester) async {
      await _pump(
        tester,
        const Center(child: SplashWordmark()),
        locale: const Locale('ar'),
      );
      await _save(tester, '08-splash-ar');
    });

    testWidgets('onboarding page one, english', (WidgetTester tester) async {
      await _pump(tester, const OnboardingScreen(), locale: const Locale('en'));
      await _save(tester, '09-onboarding-en');
    });

    testWidgets('onboarding page one, arabic', (WidgetTester tester) async {
      await _pump(tester, const OnboardingScreen(), locale: const Locale('ar'));
      await _save(tester, '10-onboarding-ar');
    });

    testWidgets('onboarding at 200% text scale', (WidgetTester tester) async {
      await _pump(
        tester,
        const OnboardingScreen(),
        locale: const Locale('en'),
        textScaler: const TextScaler.linear(2),
      );
      await _save(tester, '11-onboarding-en-200pc');
    });
  });

  group('log gate', () {
    testWidgets('idle, english', (WidgetTester tester) async {
      await _pump(tester, const LogScreen(), locale: const Locale('en'));
      await _save(tester, '12-log-idle-en');
    });

    testWidgets('idle, arabic', (WidgetTester tester) async {
      await _pump(tester, const LogScreen(), locale: const Locale('ar'));
      await _save(tester, '13-log-idle-ar');
    });

    testWidgets('draft with the cta live', (WidgetTester tester) async {
      await _pump(tester, const LogScreen(), locale: const Locale('en'));
      await tester.enterText(
        find.byType(TextField).first,
        'Two eggs, brown toast and orange juice',
      );
      await tester.pumpAndSettle();
      await _save(tester, '14-log-draft-en');
    });

    testWidgets('analyzing', (WidgetTester tester) async {
      await _pump(tester, const LogScreen(), locale: const Locale('en'));
      await tester.enterText(find.byType(TextField).first, 'Eggs and toast');
      await tester.pump();
      sl<LogCubit>().startAnalysis();
      // Far enough in for the progress line to advance, well short of the
      // mock repo's 5s answer.
      await tester.pump(const Duration(seconds: 4));
      await _save(tester, '15-log-analyzing-en');
      // Two timers are still armed: the cubit's 1s progress ticker and the
      // mock repo's 5s delayed answer. Both must be drained or the test
      // ends on a pending-timer assertion.
      sl<LogCubit>().cancelAnalysis();
      await tester.pump(const Duration(seconds: 6));
      await tester.pumpAndSettle();
    });

    testWidgets('result card', (WidgetTester tester) async {
      await _pump(tester, const LogScreen(), locale: const Locale('en'));
      await tester.enterText(find.byType(TextField).first, 'Eggs and toast');
      await tester.pump();
      sl<LogCubit>().startAnalysis();
      // The mock repo answers on a 5s delayed future, which is a fake timer
      // here — advance past it rather than waiting it out for real.
      await tester.pump(const Duration(seconds: 6));
      await tester.pumpAndSettle();
      await _save(tester, '16-log-result-en');
    });
  });

  group('review gate', () {
    testWidgets('day, english', (WidgetTester tester) async {
      await _pump(tester, const ReviewScreen(), locale: const Locale('en'));
      await _settleRepo(tester);
      await _save(tester, '17-review-day-en');
    });

    testWidgets('day, arabic', (WidgetTester tester) async {
      await _pump(tester, const ReviewScreen(), locale: const Locale('ar'));
      await _settleRepo(tester);
      await _save(tester, '18-review-day-ar');
    });

    testWidgets('week, english', (WidgetTester tester) async {
      await _pump(tester, const ReviewScreen(), locale: const Locale('en'));
      await _settleRepo(tester);
      sl<ReviewCubit>().toggleMode(ReviewMode.week);
      await _settleRepo(tester);
      await _save(tester, '19-review-week-en');
    });
  });
}

Future<void> _pump(
  WidgetTester tester,
  Widget screen, {
  required Locale locale,
  TextScaler textScaler = TextScaler.noScaling,
}) async {
  await pumpNesbaWidget(
    tester,
    RepaintBoundary(key: _shotKey, child: screen),
    locale: locale,
    textScaler: textScaler,
    // Entrance animations are the settled state's enemy here: animate_do
    // starts behind a 300ms delay timer, and `pumpAndSettle` returns as
    // soon as no frame is scheduled — which is before that timer fires,
    // capturing the screen at opacity 0. Reduced motion makes every
    // `CustomFadeInUp` hand back its child directly, so what is captured
    // is the final frame rather than the first.
    disableAnimations: true,
  );
}

/// Drains a mock repo's delayed answer.
///
/// `pumpAndSettle` alone is not enough: it stops once no frame is
/// scheduled, and a pending `Future.delayed` schedules none. Advancing the
/// clock explicitly resolves it, and leaving it pending would also trip
/// the end-of-test pending-timer check.
Future<void> _settleRepo(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();
}

Future<void> _save(WidgetTester tester, String name) async {
  final RenderRepaintBoundary boundary = tester.renderObject(
    find.byKey(_shotKey),
  );
  // toImage resolves on the real event loop, which the test zone blocks.
  await tester.runAsync(() async {
    final ui.Image image = await boundary.toImage(pixelRatio: _pixelRatio);
    final ByteData? png = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    image.dispose();
    if (png == null) return;
    File(
      '$_outputDir${Platform.pathSeparator}$name.png',
    ).writeAsBytesSync(png.buffer.asUint8List());
  });
}

/// Widget tests ship a placeholder font, so the real Plex faces and the
/// icon glyphs have to be registered by hand or everything renders as a box.
Future<void> _loadProjectFonts() async {
  await _loadMaterialIcons();
  const Map<String, List<String>> families = <String, List<String>>{
    'IBM Plex Sans': <String>[
      'assets/fonts/IBMPlexSans-Regular.ttf',
      'assets/fonts/IBMPlexSans-Medium.ttf',
    ],
    'IBM Plex Sans Arabic': <String>[
      'assets/fonts/IBMPlexSansArabic-Regular.ttf',
      'assets/fonts/IBMPlexSansArabic-SemiBold.ttf',
    ],
  };

  for (final MapEntry<String, List<String>> family in families.entries) {
    final FontLoader loader = FontLoader(family.key);
    for (final String path in family.value) {
      loader.addFont(_readFont(File('${Directory.current.path}/$path')));
    }
    await loader.load();
  }
}

/// Icon glyphs live in the SDK cache, not in the project.
Future<void> _loadMaterialIcons() async {
  final String? root = Platform.environment['FLUTTER_ROOT'];
  if (root == null) return;
  final File font = File(
    '$root/bin/cache/artifacts/material_fonts/materialicons-regular.otf',
  );
  if (!font.existsSync()) return;
  await (FontLoader('MaterialIcons')..addFont(_readFont(font))).load();
}

Future<ByteData> _readFont(File file) => Future<ByteData>.value(
  ByteData.sublistView(Uint8List.fromList(file.readAsBytesSync())),
);
