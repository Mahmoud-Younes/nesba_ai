import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/screens/nutritional_lookup_screen.dart';
import 'package:nesba_ai/theme/bustan_theme.dart';

void main() {
  const loadingDuration = Duration(milliseconds: 700);

  Future<void> pumpScreen(
    WidgetTester tester, {
    bool previewError = false,
    TextDirection? direction,
    double textScaleFactor = 1,
  }) async {
    final screen = previewError
        ? const NutritionalLookupScreen.debugErrorPreview(
            key: ValueKey('error-preview'),
          )
        : const NutritionalLookupScreen(key: ValueKey('normal-screen'));
    await tester.pumpWidget(
      MaterialApp(
        theme: BustanTheme.light(),
        home: Builder(
          builder: (context) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(textScaleFactor)),
            child: direction == null
                ? screen
                : Directionality(textDirection: direction, child: screen),
          ),
        ),
      ),
    );
  }

  Future<void> submitDescription(WidgetTester tester) async {
    await tester.enterText(
      find.byKey(const ValueKey('meal-description')),
      'Lentil soup and bread',
    );
    await tester.tap(find.byKey(const ValueKey('analyze-button')));
    await tester.pump();
  }

  testWidgets('renders the initial composer with no meal type selected', (
    tester,
  ) async {
    await pumpScreen(tester);

    expect(find.text('Describe your meal'), findsOneWidget);
    expect(find.byKey(const ValueKey('meal-description')), findsOneWidget);
    expect(find.text('Meal Type (optional)'), findsOneWidget);
    expect(find.text('Analyze'), findsOneWidget);
    expect(find.byType(ChoiceChip), findsNWidgets(4));
    for (final type in ['breakfast', 'lunch', 'dinner', 'snack']) {
      expect(
        tester
            .widget<ChoiceChip>(find.byKey(ValueKey('meal-type-$type')))
            .selected,
        isFalse,
      );
    }
    expect(find.text('Illustrative sample only'), findsNothing);
  });

  testWidgets('meal type is optional and a selected choice can be cleared', (
    tester,
  ) async {
    await pumpScreen(tester);
    final lunch = find.byKey(const ValueKey('meal-type-lunch'));

    await tester.tap(lunch);
    await tester.pump();
    expect(tester.widget<ChoiceChip>(lunch).selected, isTrue);

    await tester.tap(lunch);
    await tester.pump();
    expect(tester.widget<ChoiceChip>(lunch).selected, isFalse);
    expect(find.text('Analyze'), findsOneWidget);
  });

  testWidgets('empty description shows validation without starting preview', (
    tester,
  ) async {
    await pumpScreen(tester);
    await tester.tap(find.byKey(const ValueKey('analyze-button')));
    await tester.pump();

    expect(find.text('Please describe your meal.'), findsOneWidget);
    expect(find.text('Preparing preview…'), findsNothing);
    expect(find.text('Illustrative sample only'), findsNothing);
  });

  testWidgets('valid Analyze shows a short simulated loading state', (
    tester,
  ) async {
    await pumpScreen(tester);
    await submitDescription(tester);

    expect(find.text('Preparing preview…'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Illustrative sample only'), findsNothing);

    await tester.pump(loadingDuration);
    expect(find.text('Illustrative sample only'), findsOneWidget);
  });

  testWidgets('Analyze and loading state expand for large text', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await pumpScreen(tester, textScaleFactor: 2);
    final analyzeButton = find.byKey(const ValueKey('analyze-button'));
    await tester.ensureVisible(analyzeButton);

    expect(tester.getSize(analyzeButton).height, greaterThanOrEqualTo(48));
    expect(tester.takeException(), isNull);

    await tester.enterText(
      find.byKey(const ValueKey('meal-description')),
      'Lentil soup and bread',
    );
    tester.testTextInput.hide();
    await tester.pump();
    await tester.ensureVisible(analyzeButton);
    await tester.pumpAndSettle();
    await tester.tap(analyzeButton);
    await tester.pump();

    expect(find.text('Preparing preview…'), findsOneWidget);
    expect(tester.getSize(analyzeButton).height, greaterThanOrEqualTo(48));
    expect(tester.takeException(), isNull);
  });

  testWidgets('result and every sample value are labeled illustrative', (
    tester,
  ) async {
    await pumpScreen(tester);
    await submitDescription(tester);
    await tester.pump(loadingDuration);

    expect(find.text('Illustrative sample only'), findsOneWidget);
    expect(find.text('Not calculated from your meal.'), findsOneWidget);
    expect(find.text('Energy'), findsOneWidget);
    expect(find.text('Illustrative: 520 kcal'), findsOneWidget);
    expect(find.text('Protein'), findsOneWidget);
    expect(find.text('Illustrative: 38 g'), findsOneWidget);
    expect(find.text('Carbohydrates'), findsOneWidget);
    expect(find.text('Illustrative: 54 g'), findsOneWidget);
    expect(find.text('Fat'), findsOneWidget);
    expect(find.text('Illustrative: 16 g'), findsOneWidget);
  });

  testWidgets('development-only error preview has no normal UI control', (
    tester,
  ) async {
    await pumpScreen(tester, previewError: true);

    expect(find.text('Preview unavailable'), findsOneWidget);
    expect(
      find.text(
        'This is a simulated preview error. No analysis service was contacted.',
      ),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('retry-button')), findsOneWidget);
    expect(find.text('Debug'), findsNothing);

    await pumpScreen(tester);
    expect(find.text('Preview unavailable'), findsNothing);
    expect(find.byKey(const ValueKey('retry-button')), findsNothing);
  });

  testWidgets('Retry shows loading then the illustrative result', (
    tester,
  ) async {
    await pumpScreen(tester, previewError: true);
    final retry = find.byKey(const ValueKey('retry-button'));
    await tester.ensureVisible(retry);
    await tester.tap(retry);
    await tester.pump();

    expect(find.text('Preparing preview…'), findsOneWidget);
    expect(find.text('Preview unavailable'), findsNothing);

    await tester.pump(loadingDuration);
    expect(find.text('Illustrative sample only'), findsOneWidget);
    expect(find.text('Not calculated from your meal.'), findsOneWidget);
  });

  testWidgets('renders and supports meal choices and result in RTL', (
    tester,
  ) async {
    await pumpScreen(tester, direction: TextDirection.rtl);

    expect(tester.takeException(), isNull);
    for (final label in [
      'Describe your meal',
      'Meal Description',
      'Meal Type (optional)',
      'Breakfast',
      'Lunch',
      'Dinner',
      'Snack',
      'Analyze',
    ]) {
      expect(find.text(label), findsOneWidget);
    }

    await tester.tap(find.byKey(const ValueKey('meal-type-lunch')));
    await tester.pump();
    expect(
      tester
          .widget<ChoiceChip>(find.byKey(const ValueKey('meal-type-lunch')))
          .selected,
      isTrue,
    );
    expect(tester.takeException(), isNull);

    await submitDescription(tester);
    await tester.pump(loadingDuration);
    expect(find.text('Illustrative sample only'), findsOneWidget);
    expect(find.text('Illustrative: 520 kcal'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
