import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

/// Mock login — real FirebaseAuth wiring follows the social project's login
/// cubit when the data layer ships.
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  static final RegExp _emailRegExp = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');

  // Editing a field clears its error.
  void emailChanged(String value) =>
      emit(state.copyWith(email: value, emailError: null));

  void passwordChanged(String value) =>
      emit(state.copyWith(password: value, passwordError: null));

  // Field error texts arrive pre-translated (cubit holds no BuildContext).
  Future<void> login({
    required String invalidEmailText,
    required String shortPasswordText,
  }) async {
    final String email = state.email.trim();
    final bool emailOk = _emailRegExp.hasMatch(email);
    final bool passwordOk = state.password.length >= 6;
    if (!emailOk || !passwordOk) {
      emit(state.copyWith(
        emailError: emailOk ? null : invalidEmailText,
        passwordError: passwordOk ? null : shortPasswordText,
      ));
      return;
    }
    emit(state.copyWith(
      status: LoginStatus.loading,
      emailError: null,
      passwordError: null,
    ));
    // TODO(firebase): FirebaseAuth signInWithEmailAndPassword (social
    // pattern) — failures emit LoginStatus.error with login_error_invalid.
    await Future.delayed(const Duration(milliseconds: 800));
    emit(state.copyWith(status: LoginStatus.success));
  }
}
