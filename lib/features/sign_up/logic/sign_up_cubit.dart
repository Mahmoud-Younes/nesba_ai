import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_cubit.freezed.dart';
part 'sign_up_state.dart';

/// Mock signup — real FirebaseAuth wiring follows the social project's signup
/// cubit when the data layer ships.
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  static final RegExp _emailRegExp = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');

  // Editing a field clears its error.
  void nameChanged(String value) =>
      emit(state.copyWith(name: value, nameError: null));

  void emailChanged(String value) =>
      emit(state.copyWith(email: value, emailError: null));

  void passwordChanged(String value) =>
      emit(state.copyWith(password: value, passwordError: null));

  void confirmPasswordChanged(String value) =>
      emit(state.copyWith(confirmPassword: value, confirmPasswordError: null));

  // Field error texts arrive pre-translated (cubit holds no BuildContext).
  Future<void> signup({
    required String nameEmptyText,
    required String invalidEmailText,
    required String shortPasswordText,
    required String passwordMismatchText,
  }) async {
    final String name = state.name.trim();
    final String email = state.email.trim();
    final bool nameOk = name.isNotEmpty;
    final bool emailOk = _emailRegExp.hasMatch(email);
    final bool passwordOk = state.password.length >= 6;
    final bool matchOk = state.confirmPassword == state.password;
    if (!nameOk || !emailOk || !passwordOk || !matchOk) {
      emit(
        state.copyWith(
          nameError: nameOk ? null : nameEmptyText,
          emailError: emailOk ? null : invalidEmailText,
          passwordError: passwordOk ? null : shortPasswordText,
          confirmPasswordError: matchOk ? null : passwordMismatchText,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        status: SignUpStatus.loading,
        nameError: null,
        emailError: null,
        passwordError: null,
        confirmPasswordError: null,
      ),
    );
    // TODO(firebase): FirebaseAuth createUserWithEmailAndPassword — failures emit SignUpStatus.error.
    await Future.delayed(const Duration(milliseconds: 800));
    emit(state.copyWith(status: SignUpStatus.success));
  }
}
