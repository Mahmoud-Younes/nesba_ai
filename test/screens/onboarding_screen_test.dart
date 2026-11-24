import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/screens/onboarding_screen.dart';
import 'package:nesba_ai/theme/bustan_theme.dart';

void main() {
  Future<void> pumpOnboarding(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(theme: BustanTheme.light(), home: const OnboardingScreen()),
    );
  }

  Future<void> tapAndSettle(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  CheckboxListTile checkboxFor(WidgetTester tester, String label) {
    final tile = find.ancestor(
      of: find.text(label),
      matching: find.byType(CheckboxListTile),
    );
    return tester.widget<CheckboxListTile>(tile.first);
  }

  bool dairyIsChecked(WidgetTester tester) =>
      tester
          .widget<Checkbox>(find.byKey(const ValueKey('dairy-checkbox')))
          .value ??
      false;

  String? selectedPattern(WidgetTester tester) => tester
      .widget<RadioGroup<String>>(find.byType(RadioGroup<String>))
      .groupValue;

  testWidgets('starts with no Eating Pattern or ingredients selected', (
    tester,
  ) async {
    await pumpOnboarding(tester);

    expect(
      tester.widgetList<RadioListTile<String>>(
        find.byType(RadioListTile<String>),
      ),
      hasLength(3),
    );
    expect(selectedPattern(tester), isNull);
    expect(checkboxFor(tester, 'Gluten-containing ingredients').value, isFalse);
    expect(checkboxFor(tester, 'Other').value, isFalse);
    expect(dairyIsChecked(tester), isFalse);
  });

  testWidgets('Eating Pattern selection replaces the previous option', (
    tester,
  ) async {
    await pumpOnboarding(tester);
    await tapAndSettle(tester, find.text('Vegetarian'));
    await tapAndSettle(tester, find.text('Pescatarian'));

    expect(selectedPattern(tester), 'pescatarian');
  });

  testWidgets('Ingredients to Avoid options can be selected independently', (
    tester,
  ) async {
    await pumpOnboarding(tester);
    await tapAndSettle(tester, find.text('Gluten-containing ingredients'));
    await tapAndSettle(tester, find.text('Dairy ingredients'));

    expect(checkboxFor(tester, 'Gluten-containing ingredients').value, isTrue);
    expect(dairyIsChecked(tester), isTrue);
  });

  testWidgets('Vegan shows Dairy as Included with Vegan', (tester) async {
    await pumpOnboarding(tester);
    await tapAndSettle(tester, find.text('Vegan'));

    expect(find.text('Included with Vegan'), findsOneWidget);
    expect(find.byKey(const ValueKey('dairy-checkbox')), findsNothing);
    expect(
      find.ancestor(
        of: find.text('Dairy ingredients'),
        matching: find.byType(CheckboxListTile),
      ),
      findsNothing,
    );
  });

  testWidgets('restores an explicit Dairy selection after deselecting Vegan', (
    tester,
  ) async {
    await pumpOnboarding(tester);
    await tapAndSettle(tester, find.text('Dairy ingredients'));
    await tapAndSettle(tester, find.text('Vegan'));
    expect(find.text('Included with Vegan'), findsOneWidget);

    await tapAndSettle(tester, find.text('Pescatarian'));

    expect(dairyIsChecked(tester), isTrue);
  });

  testWidgets('Dairy returns unchecked if it was not explicitly selected', (
    tester,
  ) async {
    await pumpOnboarding(tester);
    await tapAndSettle(tester, find.text('Vegan'));
    await tapAndSettle(tester, find.text('Pescatarian'));

    expect(dairyIsChecked(tester), isFalse);
  });

  testWidgets('selecting Other reveals a multiline details field', (
    tester,
  ) async {
    await pumpOnboarding(tester);
    await tapAndSettle(tester, find.text('Other'));

    final field = tester.widget<TextField>(
      find.byKey(const ValueKey('other-details')),
    );
    expect(field.minLines, 2);
    expect(field.maxLines, 4);
    expect(find.text('Add details (optional)'), findsOneWidget);
  });

  testWidgets('Other draft text is preserved when hidden and shown again', (
    tester,
  ) async {
    await pumpOnboarding(tester);
    await tapAndSettle(tester, find.text('Other'));
    await tester.enterText(
      find.byKey(const ValueKey('other-details')),
      'A preference note',
    );
    await tester.pump();

    await tapAndSettle(tester, find.text('Other'));
    expect(find.byKey(const ValueKey('other-details')), findsNothing);
    await tapAndSettle(tester, find.text('Other'));

    expect(find.text('A preference note'), findsOneWidget);
  });

  testWidgets('allergen disclaimer is visible as readable body text', (
    tester,
  ) async {
    await pumpOnboarding(tester);

    const disclaimer =
        'These preferences guide suggestions. They don’t guarantee that a meal or recipe is free from allergens.';
    final text = tester.widget<Text>(find.text(disclaimer));
    expect(text.style?.fontSize, greaterThanOrEqualTo(14));
    expect(text.style?.color, BustanTheme.onSurface);
  });

  testWidgets(
    'Vegan makes Dairy informational and changing pattern restores unchecked Dairy',
    (tester) async {
      await pumpOnboarding(tester);
      await tapAndSettle(tester, find.text('Vegan'));

      expect(find.text('Included with Vegan'), findsOneWidget);
      expect(find.byKey(const ValueKey('dairy-checkbox')), findsNothing);
      await tapAndSettle(tester, find.text('Included with Vegan'));
      expect(find.text('Included with Vegan'), findsOneWidget);
      expect(selectedPattern(tester), 'vegan');

      await tapAndSettle(tester, find.text('Pescatarian'));

      expect(find.text('Included with Vegan'), findsNothing);
      expect(find.byKey(const ValueKey('dairy-checkbox')), findsOneWidget);
      expect(dairyIsChecked(tester), isFalse);
    },
  );

  testWidgets('manual Dairy selection is restored after Vegan is deselected', (
    tester,
  ) async {
    await pumpOnboarding(tester);
    await tapAndSettle(tester, find.text('Dairy ingredients'));
    expect(dairyIsChecked(tester), isTrue);

    await tapAndSettle(tester, find.text('Vegan'));
    expect(find.text('Included with Vegan'), findsOneWidget);
    expect(find.byKey(const ValueKey('dairy-checkbox')), findsNothing);

    await tapAndSettle(tester, find.text('Pescatarian'));

    expect(find.text('Included with Vegan'), findsNothing);
    expect(find.byKey(const ValueKey('dairy-checkbox')), findsOneWidget);
    expect(dairyIsChecked(tester), isTrue);
  });

  testWidgets('Other text survives deselecting and reselecting Other', (
    tester,
  ) async {
    await pumpOnboarding(tester);
    await tapAndSettle(tester, find.text('Other'));
    await tester.enterText(
      find.byKey(const ValueKey('other-details')),
      'Keep this preference',
    );
    await tester.pump();

    await tapAndSettle(tester, find.text('Other'));
    expect(find.byKey(const ValueKey('other-details')), findsNothing);

    await tapAndSettle(tester, find.text('Other'));

    expect(find.text('Keep this preference'), findsOneWidget);
  });

  testWidgets('Onboarding supports RTL layout and interactions', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: BustanTheme.light(),
        home: const Directionality(
          textDirection: TextDirection.rtl,
          child: OnboardingScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(
      Directionality.of(tester.element(find.text('Dietary preferences'))),
      TextDirection.rtl,
    );

    for (final label in [
      'Eating Pattern',
      'Vegetarian',
      'Vegan',
      'Pescatarian',
      'Ingredients to Avoid',
      'Gluten-containing ingredients',
      'Dairy ingredients',
      'Other',
    ]) {
      final finder = find.text(label);
      expect(finder, findsOneWidget);
      await tester.ensureVisible(finder);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    }

    await tapAndSettle(tester, find.text('Vegan'));
    expect(find.text('Included with Vegan'), findsOneWidget);
    expect(find.byKey(const ValueKey('dairy-checkbox')), findsNothing);
    expect(tester.takeException(), isNull);

    await tapAndSettle(tester, find.text('Included with Vegan'));
    expect(selectedPattern(tester), 'vegan');
    expect(find.text('Included with Vegan'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tapAndSettle(tester, find.text('Other'));
    final otherField = find.byKey(const ValueKey('other-details'));
    await tester.ensureVisible(otherField);
    await tester.enterText(otherField, 'RTL preference note');
    await tester.pumpAndSettle();

    expect(find.text('RTL preference note'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
