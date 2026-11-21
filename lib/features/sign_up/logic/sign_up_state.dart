part of 'sign_up_cubit.dart';

enum SignUpStatus { idle, loading, success, error }

@freezed
abstract class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default(SignUpStatus.idle) SignUpStatus status,
    @Default('') String name,
    @Default('') String email,
    @Default('') String password,
    @Default('') String confirmPassword,
    // Ready-translated field messages — the screen supplies them to signup().
    String? nameError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
  }) = _SignUpState;
}
