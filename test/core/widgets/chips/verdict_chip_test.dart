import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/core/widgets/chips/verdict_chip.dart';

import '../../../helpers/pump_app.dart';

void main() {
  // (verdict, container color key, icon, ar label) — copy-deck §2.2.
  const List<(Verdict, String, IconData, String)> cases = <(
    Verdict,
    String,
    IconData,
    String
  )>[
    (Verdict.balanced, 'primaryContainer', Icons.check_circle_outline, 'متوازنة'),
    (Verdict.acceptable, 'secondaryContainer', Icons.info_outline, 'لا بأس بها'),
    (Verdict.lighten, 'tertiaryContainer', Icons.trending_down, 'يمكن تخفيفها'),
  ];

  Color containerColor(ColorScheme scheme, String key) => switch (key) {
        'primaryContainer' => scheme.primaryContainer,
        'secondaryContainer' => scheme.secondaryContainer,
        _ => scheme.tertiaryContainer,
      };

  testWidgets('each verdict paints its container color from the scheme',
      (WidgetTester tester) async {
    for (final (Verdict verdict, String key, _, _) in cases) {
      await pumpNesbaWidget(tester, VerdictChip(verdict: verdict));

      final ColorScheme scheme =
          Theme.of(tester.element(find.byType(VerdictChip))).colorScheme;
      final Container container = tester.widget<Container>(
        find.descendant(
          of: find.byType(VerdictChip),
          matching: find.byType(Container),
        ),
      );
      expect(
        (container.decoration! as BoxDecoration).color,
        containerColor(scheme, key),
        reason: 'Verdict.$verdict must use scheme.$key',
      );
    }
  });

  testWidgets('icon and localized label always render together',
      (WidgetTester tester) async {
    for (final (Verdict verdict, _, IconData icon, String label) in cases) {
      await pumpNesbaWidget(tester, VerdictChip(verdict: verdict));

      expect(find.byIcon(icon), findsOneWidget,
          reason: 'Verdict.$verdict icon');
      expect(find.text(label), findsOneWidget,
          reason: 'Verdict.$verdict localized label');
    }
  });

  testWidgets('onTap makes the chip tappable over the primaryContainer',
      (WidgetTester tester) async {
    int taps = 0;
    await pumpNesbaWidget(
      tester,
      VerdictChip(verdict: Verdict.balanced, onTap: () => taps++),
    );

    final ColorScheme scheme =
        Theme.of(tester.element(find.byType(VerdictChip))).colorScheme;
    final Material material = tester.widget<Material>(
      find.descendant(
        of: find.byType(VerdictChip),
        matching: find.byType(Material),
      ),
    );
    expect(material.color, scheme.primaryContainer);

    expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
    expect(find.text('متوازنة'), findsOneWidget);

    await tester.tap(find.text('متوازنة'));
    expect(taps, 1);
  });
}
