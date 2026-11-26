import 'package:nesba_ai/core/language/lang_keys.dart';

/// Every failure crossing a repository boundary uses one of these values.
enum AppError {
  invalidField,
  invalidCredentials,
  emailInUse,
  weakPassword,
  network,
  permissionDenied,
  quotaExceeded,
  timeout,
  malformedResponse,
  unknown,
}

extension AppErrorCopy on AppError {
  String get copyKey => switch (this) {
        AppError.invalidField => LangKeys.loginErrorInvalid,
        AppError.invalidCredentials => LangKeys.loginErrorInvalid,
        AppError.emailInUse => LangKeys.loginErrorInvalid,
        AppError.weakPassword => LangKeys.validationPasswordShort,
        AppError.network => LangKeys.errOfflineBody,
        AppError.permissionDenied => LangKeys.errServerBody,
        AppError.quotaExceeded => LangKeys.errRateLimitBody,
        AppError.timeout => LangKeys.errTimeoutBody,
        AppError.malformedResponse => LangKeys.errUnrecognizableBody,
        AppError.unknown => LangKeys.errServerBody,
      };

  bool get isTransient => switch (this) {
        AppError.network || AppError.timeout || AppError.quotaExceeded => true,
        _ => false,
      };
}

AppError appErrorFromAuthCode(String code) => switch (code) {
      'invalid-email' || 'wrong-password' || 'user-not-found' =>
        AppError.invalidCredentials,
      'email-already-in-use' => AppError.emailInUse,
      'weak-password' => AppError.weakPassword,
      'network-request-failed' => AppError.network,
      'too-many-requests' => AppError.quotaExceeded,
      _ => AppError.unknown,
    };

AppError appErrorFromFirestoreCode(String code) => switch (code) {
      'permission-denied' => AppError.permissionDenied,
      'unavailable' => AppError.network,
      'deadline-exceeded' => AppError.timeout,
      'resource-exhausted' => AppError.quotaExceeded,
      _ => AppError.unknown,
    };
