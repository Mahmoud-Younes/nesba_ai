import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/screens/ai_recipe_generator_screen.dart';
import 'package:nesba_ai/theme/bustan_theme.dart';

void main() {
  const loadingDuration = Duration(milliseconds: 700);
  const mealDescription = 'Grilled chicken with brown rice and vegetables';

  Future<void> pumpScreen(
    WidgetTester tester, {
    List<String> preferences = const [],
    bool sampleContext = false,
    TextDirection? direction,
    double textScaleFactor = 1,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: BustanTheme.light(),
        home: Builder(
          builder: (context) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(textScaleFactor)),
            child: direction == null
                ? AIRecipeGeneratorScreen(
                    originalMealDescription: mealDescription,
                    preferenceContext: preferences,
                    isSampleContext: sampleContext,
                  )
                : Directionality(
                    textDirection: direction,
                    child: AIRecipeGeneratorScreen(
                      originalMealDescription: mealDescription,
                      preferenceContext: preferences,
                      isSampleContext: sampleContext,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> generatePreview(WidgetTester tester) async {
    await tester.tap(find.byKey(const ValueKey('generate-recipe-button')));
    await tester.pump();
  }

  testWidgets('renders the original meal and action before preview', (
    tester,
  ) async {
    await pumpScreen(tester);

    expect(find.text('Alternative recipe'), findsOneWidget);
    expect(find.text('Original meal'), findsOneWidget);
    expect(find.text(mealDescription), findsOneWidget);
    expect(find.text('Generate recipe'), findsOneWidget);
    expect(find.text('Preference context'), findsNothing);
    expect(find.text('Alternative recipe preview'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('hides preference context when no explicit values are supplied', (
    tester,
  ) async {
    await pumpScreen(tester);

    expect(
      find.byKey(const ValueKey('preference-context-section')),
      findsNothing,
    );
    expect(find.byType(Checkbox), findsNothing);
    expect(find.byType(ChoiceChip), findsNothing);
    expect(find.byType(FilterChip), findsNothing);
  });

  testWidgets('shows supplied preference context as read-only content', (
    tester,
  ) async {
    await pumpScreen(
      tester,
      preferences: const ['Preference A', 'Preference B'],
    );

    expect(find.text('Preference context'), findsOneWidget);
    expect(find.text('Preference A · Preference B'), findsOneWidget);
    expect(find.byType(Checkbox), findsNothing);
    expect(find.byType(ChoiceChip), findsNothing);
    expect(find.byType(FilterChip), findsNothing);
  });

  testWidgets('filters blank preference values and hides an empty section', (
    tester,
  ) async {
    await pumpScreen(tester, preferences: const ['', '  ']);

    expect(
      find.byKey(const ValueKey('preference-context-section')),
      findsNothing,
    );
  });

  testWidgets('Generate shows simulated loading then the sample recipe', (
    tester,
  ) async {
    await pumpScreen(tester);
    await generatePreview(tester);

    expect(find.text('Preparing preview…'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Alternative recipe preview'), findsNothing);
    expect(
      tester
          .widget<FilledButton>(
            find.byKey(const ValueKey('generate-recipe-button')),
          )
          .onPressed,
      isNull,
    );

    await tester.pump(loadingDuration);

    expect(find.text('Alternative recipe preview'), findsOneWidget);
    expect(find.text('Chickpea and roasted vegetable bowl'), findsOneWidget);
    expect(find.text('Illustrative sample only'), findsOneWidget);
  });

  testWidgets(
    'clearly labels sample recipe content and excludes claims/actions',
    (tester) async {
      await pumpScreen(tester);
      await generatePreview(tester);
      await tester.pump(loadingDuration);

      final result = find.byKey(const ValueKey('alternative-recipe-preview'));
      await tester.ensureVisible(result);

      expect(find.text('Illustrative ingredients'), findsOneWidget);
      expect(find.textContaining('Chickpeas'), findsOneWidget);
      expect(find.textContaining('Brown rice'), findsOneWidget);
      expect(find.textContaining('Roasted vegetables'), findsOneWidget);
      expect(find.text('Illustrative preparation steps'), findsOneWidget);
      expect(
        find.textContaining('Roast the vegetables until tender.'),
        findsOneWidget,
      );
      expect(find.textContaining('Not generated by AI'), findsOneWidget);
      expect(find.textContaining('not personalized'), findsOneWidget);
      expect(find.textContaining('nutrition verified'), findsOneWidget);
      expect(find.textContaining('kcal'), findsNothing);
      expect(find.text('Save'), findsNothing);
      expect(find.text('Healthier'), findsNothing);
    },
  );

  testWidgets(
    'sample meal and preference labels are explicit in preview mode',
    (tester) async {
      await pumpScreen(
        tester,
        preferences: const ['Example preference'],
        sampleContext: true,
      );

      expect(
        find.text('Example meal and preference context for this preview only.'),
        findsOneWidget,
      );
    },
  );

  testWidgets('the result is reachable by scrolling on a compact viewport', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await pumpScreen(tester);
    await generatePreview(tester);
    await tester.pump(loadingDuration);

    final result = find.byKey(const ValueKey('alternative-recipe-preview'));
    await tester.ensureVisible(result);

    expect(find.text('Alternative recipe preview'), findsOneWidget);
    expect(find.text('Illustrative preparation steps'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('large text and RTL remain accessible without overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await pumpScreen(
      tester,
      preferences: const ['Preference A', 'Preference B'],
      direction: TextDirection.rtl,
      textScaleFactor: 2,
    );

    final generateButton = find.byKey(const ValueKey('generate-recipe-button'));
    await tester.ensureVisible(generateButton);
    expect(tester.getSize(generateButton).height, greaterThanOrEqualTo(48));
    expect(tester.takeException(), isNull);

    await generatePreview(tester);
    await tester.pump(loadingDuration);
    final result = find.byKey(const ValueKey('alternative-recipe-preview'));
    await tester.ensureVisible(result);

    expect(find.text('Alternative recipe preview'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('loading status is exposed as an accessible live region', (
    tester,
  ) async {
    await pumpScreen(tester);
    await generatePreview(tester);

    final status = tester.widget<Semantics>(
      find.byKey(const ValueKey('preview-loading-status')),
    );
    expect(status.properties.liveRegion, isTrue);
    expect(
      tester
          .getSize(find.byKey(const ValueKey('generate-recipe-button')))
          .height,
      greaterThanOrEqualTo(48),
    );
  });
}
