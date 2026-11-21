part of 'login_cubit.dart';

enum LoginStatus { idle, loading, success, error }

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default(LoginStatus.idle) LoginStatus status,
    @Default('') String email,
    @Default('') String password,
    // Ready-translated field messages — the screen supplies them to login().
    String? emailError,
    String? passwordError,
  }) = _LoginState;
}
