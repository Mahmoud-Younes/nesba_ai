import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nesba_ai/core/app/bloc_observer.dart';
import 'package:nesba_ai/core/di/injection_container.dart';
import 'package:nesba_ai/core/service/shared_pref/shared_pref.dart';
import 'package:nesba_ai/nesba_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (Android: com.example.nesba_ai, project: nesba-5a3fb).
  await Firebase.initializeApp();

  // Initialize SharedPreferences before the app runs (theme + language).
  await SharedPref().instantiatePreferences();

  // Register all cubits/blocs inside GetIt (service locator).
  await setupInjector();

  // Log every cubit/bloc create/change in the debug console.
  Bloc.observer = AppBlocObserver();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  ).then((_) {
    runApp(const NesbaApp());
  });
}
