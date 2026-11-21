import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/features/sign_up/logic/sign_up_cubit.dart';

void main() {
  test('empty name blocks signup with the name error', () async {
    final cubit = SignUpCubit();
    cubit.emailChanged('user@nesba.app');
    cubit.passwordChanged('123456');
    cubit.confirmPasswordChanged('123456');
    await cubit.signup(
      nameEmptyText: 'الاسم فارغ',
      invalidEmailText: 'بريد إلكتروني غير صالح',
      shortPasswordText: 'كلمة المرور قصيرة',
      passwordMismatchText: 'كلمتا المرور غير متطابقتين',
    );
    expect(cubit.state.nameError, 'الاسم فارغ');
    expect(cubit.state.emailError, isNull);
    expect(cubit.state.passwordError, isNull);
    expect(cubit.state.confirmPasswordError, isNull);
    expect(cubit.state.status, SignUpStatus.idle);
    await cubit.close();
  });

  test('invalid email blocks signup with the email error', () async {
    final cubit = SignUpCubit();
    cubit.nameChanged('يونس');
    cubit.emailChanged('not-an-email');
    cubit.passwordChanged('123456');
    cubit.confirmPasswordChanged('123456');
    await cubit.signup(
      nameEmptyText: 'الاسم فارغ',
      invalidEmailText: 'بريد إلكتروني غير صالح',
      shortPasswordText: 'كلمة المرور قصيرة',
      passwordMismatchText: 'كلمتا المرور غير متطابقتين',
    );
    expect(cubit.state.nameError, isNull);
    expect(cubit.state.emailError, 'بريد إلكتروني غير صالح');
    expect(cubit.state.passwordError, isNull);
    expect(cubit.state.confirmPasswordError, isNull);
    expect(cubit.state.status, SignUpStatus.idle);
    await cubit.close();
  });

  test('short password blocks signup with the password error', () async {
    final cubit = SignUpCubit();
    cubit.nameChanged('يونس');
    cubit.emailChanged('user@nesba.app');
    cubit.passwordChanged('123');
    cubit.confirmPasswordChanged('123');
    await cubit.signup(
      nameEmptyText: 'الاسم فارغ',
      invalidEmailText: 'بريد إلكتروني غير صالح',
      shortPasswordText: 'كلمة المرور قصيرة',
      passwordMismatchText: 'كلمتا المرور غير متطابقتين',
    );
    expect(cubit.state.nameError, isNull);
    expect(cubit.state.emailError, isNull);
    expect(cubit.state.passwordError, 'كلمة المرور قصيرة');
    expect(cubit.state.confirmPasswordError, isNull);
    expect(cubit.state.status, SignUpStatus.idle);
    await cubit.close();
  });

  test('password mismatch blocks signup with the confirm error', () async {
    final cubit = SignUpCubit();
    cubit.nameChanged('يونس');
    cubit.emailChanged('user@nesba.app');
    cubit.passwordChanged('123456');
    cubit.confirmPasswordChanged('1234567');
    await cubit.signup(
      nameEmptyText: 'الاسم فارغ',
      invalidEmailText: 'بريد إلكتروني غير صالح',
      shortPasswordText: 'كلمة المرور قصيرة',
      passwordMismatchText: 'كلمتا المرور غير متطابقتين',
    );
    expect(cubit.state.nameError, isNull);
    expect(cubit.state.emailError, isNull);
    expect(cubit.state.passwordError, isNull);
    expect(cubit.state.confirmPasswordError, 'كلمتا المرور غير متطابقتين');
    expect(cubit.state.status, SignUpStatus.idle);
    await cubit.close();
  });

  test('all four field errors arrive together when everything is invalid',
      () async {
    final cubit = SignUpCubit();
    cubit.emailChanged('bad');
    cubit.passwordChanged('123');
    cubit.confirmPasswordChanged('1234');
    await cubit.signup(
      nameEmptyText: 'الاسم فارغ',
      invalidEmailText: 'بريد إلكتروني غير صالح',
      shortPasswordText: 'كلمة المرور قصيرة',
      passwordMismatchText: 'كلمتا المرور غير متطابقتين',
    );
    expect(cubit.state.nameError, 'الاسم فارغ');
    expect(cubit.state.emailError, 'بريد إلكتروني غير صالح');
    expect(cubit.state.passwordError, 'كلمة المرور قصيرة');
    expect(cubit.state.confirmPasswordError, 'كلمتا المرور غير متطابقتين');
    expect(cubit.state.status, SignUpStatus.idle);
    await cubit.close();
  });

  test('editing a field clears only its own error', () async {
    final cubit = SignUpCubit();
    cubit.emailChanged('bad');
    cubit.passwordChanged('123');
    cubit.confirmPasswordChanged('1234');
    await cubit.signup(
      nameEmptyText: 'الاسم فارغ',
      invalidEmailText: 'بريد إلكتروني غير صالح',
      shortPasswordText: 'كلمة المرور قصيرة',
      passwordMismatchText: 'كلمتا المرور غير متطابقتين',
    );
    cubit.nameChanged('يونس');
    expect(cubit.state.nameError, isNull);
    expect(cubit.state.emailError, 'بريد إلكتروني غير صالح');
    expect(cubit.state.passwordError, 'كلمة المرور قصيرة');
    expect(cubit.state.confirmPasswordError, 'كلمتا المرور غير متطابقتين');
    cubit.emailChanged('user@nesba.app');
    expect(cubit.state.emailError, isNull);
    await cubit.close();
  });

  test('valid fields pass loading then success', () async {
    final cubit = SignUpCubit();
    cubit.nameChanged('يونس');
    cubit.emailChanged(' user@nesba.app '); // trimmed before validation
    cubit.passwordChanged('123456');
    cubit.confirmPasswordChanged('123456');
    final future = cubit.signup(
      nameEmptyText: 'الاسم فارغ',
      invalidEmailText: 'بريد إلكتروني غير صالح',
      shortPasswordText: 'كلمة المرور قصيرة',
      passwordMismatchText: 'كلمتا المرور غير متطابقتين',
    );
    expect(cubit.state.status, SignUpStatus.loading);
    expect(cubit.state.nameError, isNull);
    expect(cubit.state.emailError, isNull);
    expect(cubit.state.passwordError, isNull);
    expect(cubit.state.confirmPasswordError, isNull);
    await future;
    expect(cubit.state.status, SignUpStatus.success);
    await cubit.close();
  });
}
