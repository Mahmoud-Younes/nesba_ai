import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nesba_ai/core/app/bloc_observer.dart';
import 'package:nesba_ai/core/di/injection_container.dart';
import 'package:nesba_ai/core/helpers/app_logger.dart';
import 'package:nesba_ai/core/service/shared_pref/shared_pref.dart';
import 'package:nesba_ai/firebase_options.dart';
import 'package:nesba_ai/nesba_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  appLog('app start');

  // Initialize Firebase (Android: com.example.nesba_ai, project: nesba-5a3fb).
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // App Check must be active before Firestore or Firebase AI Logic is used.
  // Debug builds use the debug provider; its token is registered in the
  // console and is never committed.
  await FirebaseAppCheck.instance.activate(
    providerAndroid: kDebugMode
        ? const AndroidDebugProvider()
        : const AndroidPlayIntegrityProvider(),
  );
  appLog('firebase ready');

  // Initialize SharedPreferences before the app runs (theme + language).
  await SharedPref().instantiatePreferences();
  appLog('preferences ready');

  // Register all cubits/blocs inside GetIt (service locator).
  await setupInjector();
  appLog('injector ready');

  // Log every cubit/bloc create/change under the `nesba` log name.
  Bloc.observer = AppBlocObserver();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  ).then((_) {
    runApp(const NesbaApp());
  });
}
