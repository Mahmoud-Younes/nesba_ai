import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/screens/snack_discovery_screen.dart';
import 'package:nesba_ai/theme/bustan_theme.dart';

void main() {
  const loadingDuration = Duration(milliseconds: 700);
  const craving = 'A chocolate bar';

  Future<void> pumpScreen(
    WidgetTester tester, {
    List<String> preferences = const [],
    bool samplePreview = false,
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
                ? SnackDiscoveryScreen(
                    preferenceContext: preferences,
                    isSamplePreview: samplePreview,
                  )
                : Directionality(
                    textDirection: direction,
                    child: SnackDiscoveryScreen(
                      preferenceContext: preferences,
                      isSamplePreview: samplePreview,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> enterCraving(WidgetTester tester, String value) async {
    await tester.enterText(find.byKey(const ValueKey('craving-input')), value);
    await tester.pump();
  }

  Future<void> discover(WidgetTester tester) async {
    await tester.tap(
      find.byKey(const ValueKey('discover-alternatives-button')),
    );
    await tester.pump();
  }

  testWidgets('renders the initial craving input with action disabled', (
    tester,
  ) async {
    await pumpScreen(tester);

    expect(find.text('What snack are you craving?'), findsOneWidget);
    expect(
      find.text('Describe it in your own words to explore another snack idea.'),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('craving-input-card')), findsOneWidget);
    expect(find.text('For example: a chocolate bar'), findsOneWidget);
    expect(find.text('Alternative idea'), findsNothing);
    expect(
      tester
          .widget<FilledButton>(
            find.byKey(const ValueKey('discover-alternatives-button')),
          )
          .onPressed,
      isNull,
    );
    expect(find.textContaining('error'), findsNothing);
    expect(find.textContaining('required'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('keeps action disabled for whitespace-only craving text', (
    tester,
  ) async {
    await pumpScreen(tester);
    await enterCraving(tester, '   \n  ');

    expect(
      tester
          .widget<FilledButton>(
            find.byKey(const ValueKey('discover-alternatives-button')),
          )
          .onPressed,
      isNull,
    );
    expect(find.textContaining('error'), findsNothing);
    expect(find.textContaining('required'), findsNothing);
  });

  testWidgets('enables action as soon as non-whitespace text is entered', (
    tester,
  ) async {
    await pumpScreen(tester);
    await enterCraving(tester, '  chocolate bar  ');

    expect(
      tester
          .widget<FilledButton>(
            find.byKey(const ValueKey('discover-alternatives-button')),
          )
          .onPressed,
      isNotNull,
    );
  });

  testWidgets('hides preference context when none is explicitly supplied', (
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

  testWidgets('shows explicit preference context as read-only', (tester) async {
    await pumpScreen(tester, preferences: const ['Example preference']);

    expect(find.text('Preference context'), findsOneWidget);
    expect(find.text('Example preference'), findsOneWidget);
    expect(find.byType(Checkbox), findsNothing);
    expect(find.byType(ChoiceChip), findsNothing);
    expect(find.byType(FilterChip), findsNothing);
  });

  testWidgets('hides preference section when supplied values are blank', (
    tester,
  ) async {
    await pumpScreen(tester, preferences: const ['', '   ']);

    expect(
      find.byKey(const ValueKey('preference-context-section')),
      findsNothing,
    );
  });

  testWidgets(
    'Discover shows simulated loading then the paired sample result',
    (tester) async {
      await pumpScreen(tester);
      await enterCraving(tester, craving);
      await discover(tester);

      expect(find.text('Preparing preview…'), findsOneWidget);
      expect(
        find.text('This is a simulated preview; no discovery service is used.'),
        findsOneWidget,
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Alternative idea'), findsNothing);
      expect(
        tester
            .widget<FilledButton>(
              find.byKey(const ValueKey('discover-alternatives-button')),
            )
            .onPressed,
        isNull,
      );

      await tester.pump(loadingDuration);

      expect(find.text('Your craving'), findsWidgets);
      expect(
        find.descendant(
          of: find.byKey(const ValueKey('your-craving-card')),
          matching: find.text(craving),
        ),
        findsOneWidget,
      );
      expect(find.text('Alternative idea'), findsOneWidget);
      expect(find.text('Roasted chickpeas'), findsOneWidget);
    },
  );

  testWidgets(
    'labels sample content and contains no nutrition or health claims',
    (tester) async {
      await pumpScreen(tester);
      await enterCraving(tester, craving);
      await discover(tester);
      await tester.pump(loadingDuration);

      final comparison = find.byKey(
        const ValueKey('snack-alternative-comparison'),
      );
      await tester.ensureVisible(comparison);

      expect(find.text('Illustrative sample only'), findsOneWidget);
      expect(find.text('Not AI-generated or personalized.'), findsOneWidget);
      expect(find.text('Example ingredients'), findsOneWidget);
      expect(find.textContaining('Chickpeas'), findsOneWidget);
      expect(find.text('Example preparation'), findsOneWidget);
      expect(
        find.textContaining('Season the chickpeas and roast until crisp.'),
        findsOneWidget,
      );
      for (final prohibited in [
        'kcal',
        'calories',
        'saves',
        'Healthy',
        'Unhealthy',
        'Save',
        'Bookmark',
        'Swap',
      ]) {
        expect(find.textContaining(prohibited), findsNothing);
      }
    },
  );

  testWidgets('sample preference context is labeled in preview mode', (
    tester,
  ) async {
    await pumpScreen(
      tester,
      preferences: const ['Example preference context'],
      samplePreview: true,
    );

    expect(
      find.text('Preference context is sample preview data only.'),
      findsOneWidget,
    );
    expect(find.text('Example preference context'), findsOneWidget);
  });

  testWidgets('result is reachable by scrolling on a compact viewport', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await pumpScreen(tester);
    await enterCraving(tester, craving);
    await discover(tester);
    await tester.pump(loadingDuration);

    await tester.ensureVisible(
      find.byKey(const ValueKey('alternative-idea-card')),
    );
    expect(find.text('Alternative idea'), findsOneWidget);
    expect(find.text('Example preparation'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('supports RTL and large text without overflow', (tester) async {
    tester.view.physicalSize = const Size(320, 600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await pumpScreen(
      tester,
      preferences: const ['Example preference'],
      direction: TextDirection.rtl,
      textScaleFactor: 2,
    );
    await enterCraving(tester, craving);

    final button = find.byKey(const ValueKey('discover-alternatives-button'));
    await tester.ensureVisible(button);
    expect(tester.getSize(button).height, greaterThanOrEqualTo(48));
    expect(tester.takeException(), isNull);

    await discover(tester);
    await tester.pump(loadingDuration);
    await tester.ensureVisible(
      find.byKey(const ValueKey('alternative-idea-card')),
    );

    expect(find.text('Your craving'), findsNWidgets(2));
    expect(find.text('Alternative idea'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('loading and result states are announced through live regions', (
    tester,
  ) async {
    await pumpScreen(tester);
    await enterCraving(tester, craving);
    await discover(tester);

    final loadingStatus = tester.widget<Semantics>(
      find.byKey(const ValueKey('discovery-loading-status')),
    );
    expect(loadingStatus.properties.liveRegion, isTrue);

    await tester.pump(loadingDuration);
    final comparison = tester.widget<Semantics>(
      find.byKey(const ValueKey('snack-alternative-comparison')),
    );
    expect(comparison.properties.liveRegion, isTrue);
  });

  testWidgets('editing the craving clears a stale sample comparison', (
    tester,
  ) async {
    await pumpScreen(tester);
    await enterCraving(tester, craving);
    await discover(tester);
    await tester.pump(loadingDuration);

    expect(
      find.byKey(const ValueKey('snack-alternative-comparison')),
      findsOneWidget,
    );

    await enterCraving(tester, 'Another snack');

    expect(
      find.byKey(const ValueKey('snack-alternative-comparison')),
      findsNothing,
    );
    expect(find.text('Another snack'), findsOneWidget);
  });
}
