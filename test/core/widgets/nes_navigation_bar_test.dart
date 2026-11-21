import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/core/widgets/nes_navigation_bar.dart';

import '../../helpers/pump_app.dart';

void main() {
  // Gate copy from lang/ar.json — tab_log, tab_review, tab_swaps in order.
  const List<String> arLabels = <String>['سجّل', 'راجع', 'اقتراحات'];

  // tab_semantics: «{tab}، التبويب {index} من 3» with 1-based gates.
  const List<String> arTooltips = <String>[
    'سجّل، التبويب 1 من 3',
    'راجع، التبويب 2 من 3',
    'اقتراحات، التبويب 3 من 3',
  ];

  testWidgets('renders the three gates with their localized labels',
      (WidgetTester tester) async {
    await pumpNesbaWidget(
      tester,
      NesNavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (_) {},
      ),
    );

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationDestination), findsNWidgets(3));
    for (final String label in arLabels) {
      expect(find.text(label), findsOneWidget, reason: 'gate label $label');
    }
  });

  testWidgets('onDestinationSelected receives the tapped gate index',
      (WidgetTester tester) async {
    final List<int> selected = <int>[];
    await pumpNesbaWidget(
      tester,
      NesNavigationBar(
        selectedIndex: 0,
        onDestinationSelected: selected.add,
      ),
    );

    for (final String label in arLabels) {
      await tester.tap(find.text(label));
      await tester.pumpAndSettle();
    }
    expect(selected, <int>[0, 1, 2]);
  });

  testWidgets('tooltips carry the tab_semantics copy per gate',
      (WidgetTester tester) async {
    await pumpNesbaWidget(
      tester,
      NesNavigationBar(
        selectedIndex: 1,
        onDestinationSelected: (_) {},
      ),
    );

    for (final String tooltip in arTooltips) {
      expect(find.byTooltip(tooltip), findsOneWidget,
          reason: 'tooltip $tooltip');
    }
  });
}
