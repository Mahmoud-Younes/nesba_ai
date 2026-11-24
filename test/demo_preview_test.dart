import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/demo_preview.dart';

void main() {
  Future<void> pumpDemo(WidgetTester tester) async {
    await tester.pumpWidget(const DemoPreviewApp());
  }

  testWidgets('launcher groups and exposes all eight completed screens', (
    tester,
  ) async {
    await pumpDemo(tester);

    expect(find.text('Eight screen previews'), findsOneWidget);
    for (final title in [
      'Onboarding',
      'Login',
      'Register',
      'Nutritional Lookup',
      'Meal History',
      'Meal Detail',
      'AI Recipe Generator',
      'Snack Discovery',
    ]) {
      expect(find.text(title), findsOneWidget);
    }
    expect(find.text('Getting started'), findsOneWidget);
    expect(find.text('Meal tracking'), findsOneWidget);
    expect(find.text('Ideas and alternatives'), findsOneWidget);
  });

  testWidgets('each screen opens from the launcher and returns with Back', (
    tester,
  ) async {
    await pumpDemo(tester);

    const screens = <(String, String)>[
      ('onboarding', 'Dietary preferences'),
      ('login', 'Sign in'),
      ('register', 'Create account'),
      ('nutritional-lookup', 'Describe your meal'),
      ('meal-history', 'Meal History'),
      ('meal-detail', 'Meal Detail'),
      ('ai-recipe-generator', 'Alternative recipe'),
      ('snack-discovery', 'What snack are you craving?'),
    ];

    for (final (id, screenText) in screens) {
      await tester.ensureVisible(find.byKey(ValueKey('demo-screen-$id')));
      await tester.tap(find.byKey(ValueKey('demo-screen-$id')));
      await tester.pumpAndSettle();

      expect(find.text(screenText), findsWidgets, reason: id);

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.text('Eight screen previews'), findsOneWidget, reason: id);
    }
  });

  testWidgets('login and register navigate between their UI previews', (
    tester,
  ) async {
    await pumpDemo(tester);
    await tester.tap(find.byKey(const ValueKey('demo-screen-login')));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Create account'));
    await tester.pumpAndSettle();
    expect(find.text('Create account'), findsWidgets);

    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();
    expect(find.text('Sign in'), findsWidgets);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('Eight screen previews'), findsOneWidget);
  });

  testWidgets(
    'Meal History opens the separate illustrative Meal Detail sample',
    (tester) async {
      await pumpDemo(tester);
      await tester.ensureVisible(
        find.byKey(const ValueKey('demo-screen-meal-history')),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('demo-screen-meal-history')));
      await tester.pumpAndSettle();

      expect(
        find.text(
          'These entries are examples only. They are not saved or synced.',
        ),
        findsOneWidget,
      );
      expect(find.text('Separate illustrative sample content'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('demo-open-meal-detail')));
      await tester.pumpAndSettle();

      expect(find.text('Meal Detail'), findsOneWidget);
      expect(find.text('Illustrative sample only'), findsOneWidget);
      expect(
        find.text('Two eggs, brown toast and orange juice'),
        findsOneWidget,
      );

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.text('Meal History'), findsOneWidget);
      expect(find.text('Open Meal Detail sample'), findsOneWidget);
    },
  );

  testWidgets('AI and snack previews receive only explicit sample context', (
    tester,
  ) async {
    await pumpDemo(tester);
    await tester.ensureVisible(
      find.byKey(const ValueKey('demo-screen-ai-recipe-generator')),
    );
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(const ValueKey('demo-screen-ai-recipe-generator')),
    );
    await tester.pumpAndSettle();
    expect(
      find.text('Example meal and preference context for this preview only.'),
      findsOneWidget,
    );

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.byKey(const ValueKey('demo-screen-snack-discovery')),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('demo-screen-snack-discovery')));
    await tester.pumpAndSettle();
    expect(
      find.text('Preference context is sample preview data only.'),
      findsOneWidget,
    );
  });
}
