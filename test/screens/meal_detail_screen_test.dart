import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/screens/meal_detail_screen.dart';
import 'package:nesba_ai/theme/bustan_theme.dart';

void main() {
  Future<void> pumpMealDetail(
    WidgetTester tester, {
    TextDirection direction = TextDirection.ltr,
    double textScaleFactor = 1,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: BustanTheme.light(),
        home: MediaQuery(
          data: const MediaQueryData().copyWith(
            textScaler: TextScaler.linear(textScaleFactor),
          ),
          child: Directionality(
            textDirection: direction,
            child: const MealDetailScreen(),
          ),
        ),
      ),
    );
  }

  testWidgets('renders the app bar and Meal context first composition', (
    tester,
  ) async {
    await pumpMealDetail(tester);

    expect(find.text('Meal Detail'), findsOneWidget);
    expect(find.text('Meal context'), findsOneWidget);
    expect(find.text('Meal Description'), findsOneWidget);
    expect(find.text('Two eggs, brown toast and orange juice'), findsOneWidget);
    expect(find.text('Meal Type'), findsOneWidget);
    expect(find.text('Breakfast'), findsOneWidget);
    expect(find.text('Illustrative sample only'), findsOneWidget);
    expect(find.text('Nutrition snapshot'), findsOneWidget);
    expect(find.text('Analyzed items'), findsOneWidget);
    expect(find.text('Recommendation'), findsOneWidget);

    final sectionTops = [
      tester.getTopLeft(find.byKey(const ValueKey('meal-context-section'))).dy,
      tester
          .getTopLeft(find.byKey(const ValueKey('nutrition-snapshot-section')))
          .dy,
      tester
          .getTopLeft(find.byKey(const ValueKey('analyzed-items-section')))
          .dy,
      tester
          .getTopLeft(find.byKey(const ValueKey('recommendation-section')))
          .dy,
    ];
    expect(sectionTops, orderedEquals(sectionTops.toList()..sort()));
  });

  testWidgets('meal context contains only description and optional type', (
    tester,
  ) async {
    await pumpMealDetail(tester);

    expect(find.text('Not specified'), findsNothing);
    expect(find.text('Breakfast'), findsOneWidget);
    for (final disallowed in [
      'Meal name',
      'Date',
      'Time',
      'Portion size',
      'Source',
    ]) {
      expect(find.text(disallowed), findsNothing);
    }
  });

  testWidgets('nutrition fields have units and illustrative values', (
    tester,
  ) async {
    await pumpMealDetail(tester);

    expect(
      find.text('Illustrative values · not calculated from the meal'),
      findsOneWidget,
    );
    for (final label in [
      'Energy (kcal)',
      'Protein (g)',
      'Carbohydrates (g)',
      'Fat (g)',
    ]) {
      expect(find.text(label), findsOneWidget);
    }
    for (final value in [
      'Illustrative: 430',
      'Illustrative: 22',
      'Illustrative: 48',
      'Illustrative: 17',
    ]) {
      expect(find.text(value), findsOneWidget);
    }
  });

  testWidgets('shows three example items and labels quantities and values', (
    tester,
  ) async {
    await pumpMealDetail(tester);

    expect(
      find.text(
        'Examples only; items and quantities are not detected or verified.',
      ),
      findsOneWidget,
    );
    for (final example in [
      'Eggs',
      'Example quantity: 2 eggs',
      'Illustrative value: 140 kcal',
      'Brown toast',
      'Example quantity: 2 slices',
      'Illustrative value: 160 kcal',
      'Orange juice',
      'Example quantity: 250 ml',
      'Illustrative value: 130 kcal',
    ]) {
      expect(find.text(example), findsOneWidget);
    }
  });

  testWidgets('recommendation is illustrative, neutral, and non-medical', (
    tester,
  ) async {
    await pumpMealDetail(tester);
    final recommendation = find.byKey(const ValueKey('recommendation-section'));
    await tester.ensureVisible(recommendation);

    expect(
      find.text('Illustrative suggestion · not personalized'),
      findsOneWidget,
    );
    expect(
      find.text(
        'One optional variation is to serve the meal with a different side, such as roasted vegetables.',
      ),
      findsOneWidget,
    );
    for (final prohibited in ['Healthy', 'Unhealthy', 'Perfectly balanced']) {
      expect(find.textContaining(prohibited), findsNothing);
    }
    expect(find.text('Save'), findsNothing);
    expect(find.text('Healthier'), findsNothing);
    expect(find.byType(OutlinedButton), findsNothing);
    expect(find.byType(FilledButton), findsNothing);
  });

  testWidgets('large text and RTL layout render without overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await pumpMealDetail(
      tester,
      direction: TextDirection.rtl,
      textScaleFactor: 2,
    );

    expect(find.text('Meal Detail'), findsOneWidget);
    expect(find.text('Meal context'), findsOneWidget);
    expect(find.text('Nutrition snapshot'), findsOneWidget);
    expect(find.text('Analyzed items'), findsOneWidget);
    expect(find.text('Recommendation'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.ensureVisible(
      find.byKey(const ValueKey('recommendation-section')),
    );
    expect(tester.takeException(), isNull);
  });
}
