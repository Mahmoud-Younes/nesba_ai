import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart' show SemanticsNode;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/core/widgets/calorie_ring.dart';

import '../../helpers/pump_app.dart';

void main() {
  // The arc state is only observable through public widget props: the
  // CustomPaint painter + its public shouldRepaint contract — the painter
  // internals stay untouched.
  CustomPainter ringPainter(WidgetTester tester) => tester
      .widget<CustomPaint>(
        find.descendant(
          of: find.byType(CalorieRing),
          matching: find.byType(CustomPaint),
        ),
      )
      .painter!;

  SizedBox ringBox(WidgetTester tester) => tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(CalorieRing),
          matching: find.byWidgetPredicate(
            (Widget w) => w is SizedBox && w.width != null && w.width == w.height,
          ),
        ),
      );

  testWidgets('noGoal renders the bare track: paint state ignores consumed',
      (WidgetTester tester) async {
    await pumpNesbaWidget(
      tester,
      const CalorieRing(consumed: 500, goal: null, semanticsLabel: 'سعرات'),
    );
    final CustomPainter bareSmall = ringPainter(tester);
    expect(find.text('500'), findsOneWidget);

    // Different consumed, still no goal — nothing may change in the paint.
    await pumpNesbaWidget(
      tester,
      const CalorieRing(consumed: 1999, goal: null, semanticsLabel: 'سعرات'),
    );
    expect(bareSmall.shouldRepaint(ringPainter(tester)), isFalse,
        reason: 'no goal means no arc: nothing drawn scales with consumed');

    // Adding a goal (same under-target colors, same stroke) must repaint —
    // the only changing piece is the progress sweep the track lacked.
    await pumpNesbaWidget(
      tester,
      const CalorieRing(consumed: 500, goal: 1000, semanticsLabel: 'سعرات'),
    );
    expect(bareSmall.shouldRepaint(ringPainter(tester)), isTrue,
        reason: 'a goal adds the progress arc over the bare track');
  });

  testWidgets('withGoal renders the grouped count and hero caption',
      (WidgetTester tester) async {
    await pumpNesbaWidget(
      tester,
      const CalorieRing(
        consumed: 1200,
        goal: 2000,
        semanticsLabel: 'السعرات: 1,200 من 2,000',
        subtitleText: 'من 2,000 سعرة',
      ),
    );

    expect(find.text('1,200'), findsOneWidget);
    expect(find.text('من 2,000 سعرة'), findsOneWidget);
    expect(find.text('2,000'), findsNothing,
        reason: 'the goal lives in the caption only, not as a raw number');
  });

  testWidgets('over goal flips the arc color at an identical full sweep',
      (WidgetTester tester) async {
    await pumpNesbaWidget(
      tester,
      const CalorieRing(consumed: 2500, goal: 2000, semanticsLabel: 'سعرات'),
    );
    final CustomPainter over = ringPainter(tester);
    expect(find.text('2,500'), findsOneWidget);

    // Consumed == goal sweeps the full circle too — same sweep, same stroke,
    // same track; the repaint can only come from the over-target arc color.
    await pumpNesbaWidget(
      tester,
      const CalorieRing(consumed: 2000, goal: 2000, semanticsLabel: 'سعرات'),
    );
    expect(over.shouldRepaint(ringPainter(tester)), isTrue,
        reason: 'over goal must switch the arc to the over-target color');
  });

  testWidgets('hero and mini variants size 140r/40r, caption hero only',
      (WidgetTester tester) async {
    await pumpNesbaWidget(
      tester,
      const CalorieRing(
        consumed: 1240,
        goal: 2000,
        semanticsLabel: 'سعرات',
        subtitleText: 'من 2,000 سعرة',
      ),
    );
    expect(ringBox(tester).width, 140.r);
    expect(find.text('من 2,000 سعرة'), findsOneWidget);

    await pumpNesbaWidget(
      tester,
      const CalorieRing(
        consumed: 1240,
        goal: 2000,
        variant: CalorieRingVariant.mini,
        semanticsLabel: 'سعرات',
        subtitleText: 'من 2,000 سعرة',
      ),
    );
    expect(ringBox(tester).width, 40.r);
    expect(find.text('1,240'), findsOneWidget);
    expect(find.text('من 2,000 سعرة'), findsNothing,
        reason: 'the caption is hero-only (spec §2.0-A)');
  });

  testWidgets('semanticsLabel reaches Semantics and hides the ring subtree',
      (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await pumpNesbaWidget(
      tester,
      const CalorieRing(
        consumed: 1200,
        goal: 2000,
        semanticsLabel: 'السعرات: 1,200 من 2,000',
      ),
    );

    final SemanticsNode node = tester.getSemantics(
      find.bySemanticsLabel('السعرات: 1,200 من 2,000'),
    );
    expect(node.label, 'السعرات: 1,200 من 2,000');
    // The ring subtree is excluded — no node carries the bare number.
    expect(find.bySemanticsLabel('1,200'), findsNothing);
    handle.dispose();
  });
}
