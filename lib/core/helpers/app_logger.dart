import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// One logging entry point for the whole app. Everything that reports app
/// state goes through `appLog` so a single `name` filter in the IDE timeline
/// shows the full story, while the mirrored `debugPrint` line keeps the same
/// story visible in `adb logcat` without an attached debugger.
abstract final class AppLogger {
  static const String name = 'nesba';

  static void trace(String message) => _write(message, 500, 'TRACE');
  static void info(String message) => _write(message, 800, 'INFO');
  static void warning(String message) => _write(message, 900, 'WARN');
  static void error(String message, [Object? error, StackTrace? stack]) =>
      _write(message, 1000, 'ERROR', error: error, stack: stack);

  static void _write(
    String message,
    int level,
    String label, {
    Object? error,
    StackTrace? stack,
  }) {
    developer.log(
      message,
      name: name,
      level: level,
      error: error,
      stackTrace: stack,
    );
    // dart:developer does not reach logcat without an attached VM; the print
    // mirror is what makes `adb logcat -s flutter` show the app timeline.
    if (kDebugMode) {
      debugPrint('[$name][$label] $message');
      if (error != null) debugPrint('[$name][$label] error: $error');
      if (stack != null) debugPrint('[$name][$label] $stack');
    }
  }
}

/// Short alias used at every call site.
void appLog(String message, {AppLogLevel level = AppLogLevel.info}) {
  switch (level) {
    case AppLogLevel.trace:
      AppLogger.trace(message);
    case AppLogLevel.info:
      AppLogger.info(message);
    case AppLogLevel.warning:
      AppLogger.warning(message);
    case AppLogLevel.error:
      AppLogger.error(message);
  }
}

enum AppLogLevel { trace, info, warning, error }
