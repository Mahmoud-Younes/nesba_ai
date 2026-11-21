import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/core/widgets/rows/macro_grid.dart';

import '../../../helpers/pump_app.dart';

void main() {
  final List<({String current, String target})> data = <({String current, String target})>[
    (current: '78', target: '120'),
    (current: '210', target: '260'),
    (current: '42', target: '70'),
  ];

  // MacroGrid._value renders «\u2066current / target\u2069 unit» (LRI…PDI).
  List<String> valueLines() => <String>[
        '\u206678 / 120\u2069 جرام',
        '\u2066210 / 260\u2069 جرام',
        '\u206642 / 70\u2069 جرام',
      ];

  testWidgets('normal scale renders the 3-column grid',
      (WidgetTester tester) async {
    await pumpNesbaWidget(
      tester,
      MacroGrid(protein: data[0], carbs: data[1], fat: data[2]),
    );

    // 3-column mode: one Expanded cell per macro.
    final Iterable<Widget> cells = tester.widgetList(
      find.descendant(
        of: find.byType(MacroGrid),
        matching: find.byType(Expanded),
      ),
    );
    expect(cells.length, 3);

    expect(find.text('بروتين'), findsOneWidget);
    expect(find.text('كارب'), findsOneWidget);
    expect(find.text('دهون'), findsOneWidget);
    for (final String line in valueLines()) {
      expect(find.text(line), findsOneWidget, reason: 'value line $line');
    }
  });

  testWidgets('textScaler 1.6 collapses to a single column',
      (WidgetTester tester) async {
    // The FlutterTest font advances a full square per glyph (~2x the real
    // IBM Plex metrics), so the 1.6-scaled value lines overflow 390dp; a
    // wider bounded canvas keeps the collapse logic (textScaler-based) and
    // the Spacer rows intact while giving the lines room.
    await pumpNesbaWidget(
      tester,
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 480,
          child: MacroGrid(protein: data[0], carbs: data[1], fat: data[2]),
        ),
      ),
      textScaler: TextScaler.linear(1.6),
    );

    // Single-column mode: each _line row ends in a trailing Spacer — which
    // IS an Expanded subclass, so counting Expandeds cannot tell the modes
    // apart; the 3-column branch has no Spacer at all.
    expect(
      find.descendant(
        of: find.byType(MacroGrid),
        matching: find.byType(Spacer),
      ),
      findsNWidgets(3),
    );

    // All macros still present, one per line.
    expect(find.text('بروتين'), findsOneWidget);
    expect(find.text('كارب'), findsOneWidget);
    expect(find.text('دهون'), findsOneWidget);
    for (final String line in valueLines()) {
      expect(find.text(line), findsOneWidget, reason: 'value line $line');
    }
  });
}
