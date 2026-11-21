import 'dart:convert' show utf8;
import 'dart:io' show Directory, File;
import 'dart:typed_data' show ByteData, Uint8List;

import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/core/language/app_localizations_setup.dart';
import 'package:nesba_ai/core/service/shared_pref/shared_pref.dart';
import 'package:nesba_ai/core/style/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Serves project assets (lang/*.json) straight from disk over the
/// `flutter/assets` channel — same trick as the SDK's `mockFlutterAssets`.
///
/// The real asset reply only reaches the first `pumpWidget` of a process;
/// later sends are never answered inside the test's FakeAsync zone. The
/// synchronous mock keeps `AppLocalizations.load()` resolving on every pump.
void _mockAssetChannel() {
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMessageHandler('flutter/assets', (ByteData? message) {
    if (message == null) {
      return SynchronousFuture<ByteData?>(null);
    }
    final String key = utf8.decode(message.buffer.asUint8List());
    final File asset = File('${Directory.current.path}/$key');
    if (!asset.existsSync()) {
      return SynchronousFuture<ByteData?>(null);
    }
    final Uint8List bytes = Uint8List.fromList(asset.readAsBytesSync());
    return SynchronousFuture<ByteData>(
      bytes.buffer.asByteData(bytes.offsetInBytes, bytes.lengthInBytes),
    );
  });
}

/// Harnessed pump for Nesba core widget tests.
///
/// Wraps [child] in the full production stack the components expect:
/// `ScreenUtilInit(designSize: 390x844, minTextAdapt: true)` → `MaterialApp`
/// ([locale] + `AppLocalizationsSetup` delegates/locales + Bustan
/// [themeLight]/themeDark) → `Scaffold(body:)`, with an optional `MediaQuery`
/// override for [textScaler] and [disableAnimations].
///
/// Must be used instead of a bare `pumpWidget` because every core widget
/// reads `context.textStyle` (theme textTheme), `context.color`
/// (MyColors extension), `context.translate` (AppLocalizations from the
/// `lang/*.json` assets) and screenutil `.sp/.w/.h`.
///
/// Also guards the two cross-test traps under `flutter test`:
/// - `SharedPreferences.setMockInitialValues` before the theme is built —
///   `themeLight()`/`themeDark()` resolve the font family through
///   `FontFamilyHelper` → `SharedPref.sharedPreferences`, a `late static`
///   with no plugin backing under `flutter test`.
/// - `rootBundle.clear()` evicts asset futures cached under a previous
///   test's dead FakeAsync zone; awaiting them again would hang the test.
Future<void> pumpNesbaWidget(
  WidgetTester tester,
  Widget child, {
  Locale locale = const Locale('ar'),
  bool dark = false,
  TextScaler textScaler = TextScaler.noScaling,
  bool disableAnimations = false,
  bool settle = true,
}) async {
  _mockAssetChannel();
  rootBundle.clear();
  // Match the design canvas (390×844 logical) so the screenutil scales stay
  // at design units — .sp rides on scaleWidth, which would inflate text
  // ~2x on the default 800×600 test surface.
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = const Size(390, 844);
  addTearDown(tester.view.reset);
  SharedPreferences.setMockInitialValues(<String, Object>{});
  await SharedPref().instantiatePreferences();

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (_, _) => MaterialApp(
        locale: locale,
        supportedLocales: AppLocalizationsSetup.supportedLocales,
        localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
        theme: dark ? themeDark() : themeLight(),
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) => MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: textScaler,
                disableAnimations: disableAnimations,
              ),
              child: child,
            ),
          ),
        ),
      ),
    ),
  );

  // Flush the synchronous localization replies so the tree leaves the
  // Localizations loading placeholder, then settle (or hand over control
  // for tests that drive frames manually).
  await tester.pump();
  if (settle) {
    await tester.pumpAndSettle();
  } else {
    await tester.pump();
  }
}
