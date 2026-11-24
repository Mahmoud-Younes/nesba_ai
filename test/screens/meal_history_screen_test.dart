import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/screens/meal_history_screen.dart';
import 'package:nesba_ai/theme/bustan_theme.dart';

void main() {
  Future<void> pumpMealHistory(
    WidgetTester tester, {
    bool showEmptyPreview = false,
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
            child: MealHistoryScreen(showEmptyPreview: showEmptyPreview),
          ),
        ),
      ),
    );
  }

  testWidgets('renders sample notice and day card stack', (tester) async {
    await pumpMealHistory(tester);

    expect(find.text('Meal History'), findsOneWidget);
    expect(find.text('Illustrative examples'), findsOneWidget);
    expect(
      find.text(
        'These entries are examples only. They are not saved or synced.',
      ),
      findsOneWidget,
    );
    expect(find.text('Today'), findsOneWidget);
    expect(find.text('Yesterday'), findsOneWidget);
    expect(find.text('Example entry'), findsNWidgets(4));
    expect(
      find.text('Warm oatmeal with berries and a little honey.'),
      findsOneWidget,
    );
    expect(
      find.text('Grilled vegetables with rice and fresh herbs.'),
      findsOneWidget,
    );
  });

  testWidgets('does not show persistence, nutrition, or navigation controls', (
    tester,
  ) async {
    await pumpMealHistory(tester);

    for (final excluded in [
      'Save',
      'Sync',
      'Delete',
      'Filter',
      'Sort',
      'kcal',
    ]) {
      expect(find.textContaining(excluded), findsNothing);
    }
    expect(find.byType(BottomNavigationBar), findsNothing);
    expect(find.byType(NavigationBar), findsNothing);
    expect(find.byType(FilledButton), findsNothing);
    expect(find.byType(IconButton), findsNothing);
  });

  testWidgets('shows the illustrative empty preview without actions', (
    tester,
  ) async {
    await pumpMealHistory(tester, showEmptyPreview: true);

    expect(find.text('No examples are shown in this preview.'), findsOneWidget);
    expect(find.text('Today'), findsNothing);
    expect(find.text('Yesterday'), findsNothing);
    expect(find.text('Example entry'), findsNothing);
    expect(find.byType(FilledButton), findsNothing);
    expect(find.byType(TextButton), findsNothing);
  });

  testWidgets('scrolls to later sample cards', (tester) async {
    await pumpMealHistory(tester);

    final lastMeal = find.text('A crisp apple and a handful of almonds.');
    await tester.ensureVisible(lastMeal);

    expect(lastMeal, findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('large text and RTL render without layout exceptions', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await pumpMealHistory(
      tester,
      direction: TextDirection.rtl,
      textScaleFactor: 2,
    );

    expect(find.text('Meal History'), findsOneWidget);
    expect(find.text('Illustrative examples'), findsOneWidget);
    expect(find.text('Today'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.ensureVisible(
      find.text('A crisp apple and a handful of almonds.'),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('sample disclosure is exposed as a semantic announcement', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    try {
      await pumpMealHistory(tester);

      expect(
        find.bySemanticsLabel(
          'Illustrative sample only. These entries are examples and are not saved or synchronized.',
        ),
        findsOneWidget,
      );
    } finally {
      semantics.dispose();
    }
  });
}
