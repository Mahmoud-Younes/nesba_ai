import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/core/widgets/feedback/skeleton_card.dart';

import '../../../helpers/pump_app.dart';

void main() {
  // The card root + the 3 skeleton line boxes are the only Containers in the
  // subtree; shimmer lines carry a gradient, static lines do not.
  List<Container> lineBoxes(WidgetTester tester) {
    final Iterable<Container> containers = tester.widgetList<Container>(
      find.descendant(
        of: find.byType(SkeletonCard),
        matching: find.byType(Container),
      ),
    );
    return containers.skip(1).toList();
  }

  bool hasGradient(WidgetTester tester) => lineBoxes(tester)
      .any((Container c) => (c.decoration! as BoxDecoration).gradient != null);

  testWidgets('reduced motion renders static colors with no active shimmer',
      (WidgetTester tester) async {
    await pumpNesbaWidget(
      tester,
      const SkeletonCard(),
      disableAnimations: true,
      // A settled test would never finish if a controller kept repeating;
      // drive frames manually instead.
      settle: false,
    );

    expect(find.byType(SkeletonCard), findsOneWidget);
    expect(lineBoxes(tester).length, 3);
    expect(hasGradient(tester), isFalse);

    // Keep pumping real frames — the static mode must never start animating
    // (the shimmer controller is stopped before it can repeat).
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 400));
    expect(hasGradient(tester), isFalse);
  });

  testWidgets('default mode runs the manual shimmer gradient',
      (WidgetTester tester) async {
    await pumpNesbaWidget(tester, const SkeletonCard(), settle: false);

    expect(lineBoxes(tester).length, 3);
    await tester.pump(const Duration(milliseconds: 200));
    expect(hasGradient(tester), isTrue);
  });
}
