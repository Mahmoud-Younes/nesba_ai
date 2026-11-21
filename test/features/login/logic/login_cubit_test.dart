import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/features/login/logic/login_cubit.dart';

void main() {
  test('invalid email blocks login at the field level', () async {
    final cubit = LoginCubit();
    cubit.emailChanged('not-an-email');
    cubit.passwordChanged('123456');
    await cubit.login(
      invalidEmailText: 'بريد إلكتروني غير صالح',
      shortPasswordText: 'كلمة المرور قصيرة',
    );
    expect(cubit.state.emailError, 'بريد إلكتروني غير صالح');
    expect(cubit.state.passwordError, isNull);
    expect(cubit.state.status, LoginStatus.idle);
    await cubit.close();
  });

  test('short password blocks login at the field level', () async {
    final cubit = LoginCubit();
    cubit.emailChanged('user@nesba.app');
    cubit.passwordChanged('123');
    await cubit.login(
      invalidEmailText: 'بريد إلكتروني غير صالح',
      shortPasswordText: 'كلمة المرور قصيرة',
    );
    expect(cubit.state.emailError, isNull);
    expect(cubit.state.passwordError, 'كلمة المرور قصيرة');
    expect(cubit.state.status, LoginStatus.idle);
    await cubit.close();
  });

  test('both field errors arrive together when both fields are wrong',
      () async {
    final cubit = LoginCubit();
    cubit.emailChanged('bad');
    cubit.passwordChanged('123');
    await cubit.login(
      invalidEmailText: 'بريد إلكتروني غير صالح',
      shortPasswordText: 'كلمة المرور قصيرة',
    );
    expect(cubit.state.emailError, 'بريد إلكتروني غير صالح');
    expect(cubit.state.passwordError, 'كلمة المرور قصيرة');
    expect(cubit.state.status, LoginStatus.idle);
    await cubit.close();
  });

  test('editing a field clears only its own error', () async {
    final cubit = LoginCubit();
    cubit.emailChanged('bad');
    cubit.passwordChanged('123');
    await cubit.login(
      invalidEmailText: 'بريد إلكتروني غير صالح',
      shortPasswordText: 'كلمة المرور قصيرة',
    );
    cubit.emailChanged('user@nesba.app');
    expect(cubit.state.emailError, isNull);
    expect(cubit.state.passwordError, 'كلمة المرور قصيرة');
    cubit.passwordChanged('123456');
    expect(cubit.state.passwordError, isNull);
    await cubit.close();
  });

  test('valid credentials pass loading then success', () async {
    final cubit = LoginCubit();
    cubit.emailChanged(' user@nesba.app '); // trimmed before validation
    cubit.passwordChanged('123456');
    final future = cubit.login(
      invalidEmailText: 'بريد إلكتروني غير صالح',
      shortPasswordText: 'كلمة المرور قصيرة',
    );
    expect(cubit.state.status, LoginStatus.loading);
    expect(cubit.state.emailError, isNull);
    expect(cubit.state.passwordError, isNull);
    await future;
    expect(cubit.state.status, LoginStatus.success);
    await cubit.close();
  });
}
