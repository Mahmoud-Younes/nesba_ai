import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/main.dart';
import 'package:nesba_ai/screens/register_screen.dart';

void main() {
  testWidgets('Login screen renders', (tester) async {
    await tester.pumpWidget(const DietApp());

    expect(find.text('Sign in'), findsNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });

  testWidgets('Login shows the UI-only Google sign-in button', (tester) async {
    await tester.pumpWidget(const DietApp());

    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.byKey(const ValueKey('google-sign-in-button')), findsOneWidget);
  });

  testWidgets('Register screen renders without Confirm Password', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: RegisterScreen()));

    expect(find.text('Create account'), findsNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm Password'), findsNothing);
  });

  testWidgets('Register shows the UI-only Google sign-in button', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: RegisterScreen()));

    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.byKey(const ValueKey('google-sign-in-button')), findsOneWidget);
  });

  testWidgets('Register password starts hidden and toggles visibility', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: RegisterScreen()));

    EditableText passwordField() =>
        tester.widget<EditableText>(find.byType(EditableText).last);

    expect(passwordField().obscureText, isTrue);
    expect(find.byTooltip('Show password'), findsOneWidget);

    await tester.tap(find.byTooltip('Show password'));
    await tester.pump();
    expect(passwordField().obscureText, isFalse);
    expect(find.byTooltip('Hide password'), findsOneWidget);

    await tester.tap(find.byTooltip('Hide password'));
    await tester.pump();
    expect(passwordField().obscureText, isTrue);
    expect(find.byTooltip('Show password'), findsOneWidget);
  });

  testWidgets('Google button reports that sign-in is not connected', (
    tester,
  ) async {
    await tester.pumpWidget(const DietApp());

    await tester.tap(find.byKey(const ValueKey('google-sign-in-button')));
    await tester.pumpAndSettle();

    expect(
      find.text('Google sign-in is not connected in this UI-only screen.'),
      findsOneWidget,
    );
  });

  testWidgets('Navigation works between Login and Register', (tester) async {
    await tester.pumpWidget(const DietApp());

    await tester.tap(find.text('Create account'));
    await tester.pumpAndSettle();
    expect(find.text('Already have an account?'), findsOneWidget);

    await tester.tap(find.text('Sign in').last);
    await tester.pumpAndSettle();
    expect(find.text("Don't have an account?"), findsOneWidget);
  });

  testWidgets('Required fields show validation messages', (tester) async {
    await tester.pumpWidget(const DietApp());

    await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
    await tester.pumpAndSettle();

    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);
  });

  testWidgets('Password visibility can be toggled', (tester) async {
    await tester.pumpWidget(const DietApp());

    EditableText passwordField() =>
        tester.widget<EditableText>(find.byType(EditableText).last);

    expect(passwordField().obscureText, isTrue);
    await tester.tap(find.byTooltip('Show password'));
    await tester.pump();
    expect(passwordField().obscureText, isFalse);
    expect(find.byTooltip('Hide password'), findsOneWidget);
  });

  testWidgets('Valid submission shows disconnected authentication notice', (
    tester,
  ) async {
    await tester.pumpWidget(const DietApp());

    await tester.enterText(
      find.byType(TextFormField).first,
      'user@example.com',
    );
    await tester.enterText(find.byType(TextFormField).last, 'any password');
    await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
    await tester.pumpAndSettle();

    expect(
      find.text('Authentication is not connected in this UI-only screen.'),
      findsOneWidget,
    );
  });
}
