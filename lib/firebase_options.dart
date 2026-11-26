import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Firebase configuration generated from android/app/google-services.json.
/// These values are public identifiers, not secrets.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'Nesba currently supports Firebase on Android only.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMDae6_fp8T4cZjD7AKN8vinfLmblHzdo',
    appId: '1:127040816700:android:242ae207daa23479482539',
    messagingSenderId: '127040816700',
    projectId: 'nesba-5a3fb',
  );
}
