import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart'
    show SemanticsHandle, SemanticsNode;
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/core/widgets/calorie_ring.dart';
import 'package:nesba_ai/core/widgets/summary_strip.dart';

import '../../helpers/pump_app.dart';

void main() {
  // Isolated numeric path from states §3.3 — LRI…PDI around «1,240 / 2,000».
  const String numericLine = '\u20661,240 / 2,000\u2069';

  SummaryStrip strip(WidgetTester tester) =>
      tester.widget<SummaryStrip>(find.byType(SummaryStrip));

  testWidgets('noGoal shows the noGoal copy with no numeric path',
      (WidgetTester tester) async {
    await pumpNesbaWidget(
      tester,
      const SummaryStrip(
        consumed: 1200,
        goal: null,
        semanticsLabel: 'السعرات: بدون هدف',
      ),
    );

    expect(find.text('بدون هدف'), findsOneWidget);
    expect(find.textContaining('/'), findsNothing,
        reason: 'no goal means no numbers path at all');
    expect(find.byType(InkWell), findsNothing,
        reason: 'the strip is not tappable without onTap');
  });

  testWidgets('withGoal shows the isolated numeric path alone',
      (WidgetTester tester) async {
    await pumpNesbaWidget(
      tester,
      const SummaryStrip(
        consumed: 1240,
        goal: 2000,
        semanticsLabel: 'السعرات: 1,240 من 2,000',
      ),
    );

    expect(find.text(numericLine), findsOneWidget);
    expect(find.textContaining('بدون هدف'), findsNothing);

    // The embedded ring is the mini variant fed with the same numbers.
    final CalorieRing ring =
        tester.widget<CalorieRing>(find.byType(CalorieRing));
    expect(ring.variant, CalorieRingVariant.mini);
    expect(ring.consumed, 1240);
    expect(ring.goal, 2000);
  });

  testWidgets('statusText joins the numbers after the «·» separator',
      (WidgetTester tester) async {
    await pumpNesbaWidget(
      tester,
      const SummaryStrip(
        consumed: 1240,
        goal: 2000,
        statusText: 'فاضل 760',
        semanticsLabel: 'السعرات: 1,240 من 2,000',
      ),
    );

    expect(find.text('$numericLine · فاضل 760'), findsOneWidget);
  });

  testWidgets('onTap makes the whole strip tappable',
      (WidgetTester tester) async {
    int taps = 0;
    await pumpNesbaWidget(
      tester,
      SummaryStrip(
        consumed: 1240,
        goal: 2000,
        semanticsLabel: 'السعرات: 1,240 من 2,000',
        onTap: () => taps++,
      ),
    );

    expect(
      find.descendant(
        of: find.byType(SummaryStrip),
        matching: find.byType(InkWell),
      ),
      findsOneWidget,
    );

    await tester.tap(find.text(numericLine));
    await tester.pumpAndSettle();
    expect(taps, 1);
  });

  testWidgets('semantics button flag follows onTap only',
      (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await pumpNesbaWidget(
      tester,
      const SummaryStrip(
        consumed: 1240,
        goal: 2000,
        semanticsLabel: 'السعرات: 1,240 من 2,000',
      ),
    );
    // The strip Semantics carries the label; the embedded ring Semantics
    // shares it but is dropped by the strip's excludeSemantics.
    SemanticsNode node = tester.getSemantics(
      find.bySemanticsLabel('السعرات: 1,240 من 2,000'),
    );
    expect(node.flagsCollection.isButton, isFalse);

    await pumpNesbaWidget(
      tester,
      const SummaryStrip(
        consumed: 1240,
        goal: 2000,
        semanticsLabel: 'السعرات: 1,240 من 2,000',
        onTap: doNothing,
      ),
    );
    expect(strip(tester).onTap, doNothing);
    node = tester.getSemantics(
      find.bySemanticsLabel('السعرات: 1,240 من 2,000'),
    );
    expect(node.flagsCollection.isButton, isTrue);
    handle.dispose();
  });
}

void doNothing() {}
