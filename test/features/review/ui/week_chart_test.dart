import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:nesba_ai/features/review/data/models/week_summary.dart';
import 'package:nesba_ai/features/review/ui/widgets/week_chart.dart';

import '../../../helpers/pump_app.dart';

void main() {
  final List<WeekDay> days = <WeekDay>[
    WeekDay(date: DateTime(2026, 11, 16), kcal: 1240),
    WeekDay(date: DateTime(2026, 11, 17), kcal: 980),
    WeekDay(date: DateTime(2026, 11, 18)), // no data stays blank
    WeekDay(date: DateTime(2026, 11, 19), kcal: 1320),
    WeekDay(date: DateTime(2026, 11, 20), kcal: 1100),
    WeekDay(date: DateTime(2026, 11, 21), kcal: 2140),
    WeekDay(date: DateTime(2026, 11, 22), kcal: 1650),
  ];

  testWidgets('Arabic axis runs oldest left to newest right', (
    WidgetTester tester,
  ) async {
    await pumpNesbaWidget(tester, WeekChart(days: days, goal: 2000));

    final String firstLabel = DateFormat.E('ar').format(days.first.date);
    final String lastLabel = DateFormat.E('ar').format(days.last.date);
    expect(find.text(firstLabel), findsOneWidget);
    expect(find.text(lastLabel), findsOneWidget);
    expect(
      tester.getTopLeft(find.text(firstLabel)).dx,
      lessThan(tester.getTopLeft(find.text(lastLabel)).dx),
    );
  });

  testWidgets('spoken summary carries values, goal and the blank day', (
    WidgetTester tester,
  ) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await pumpNesbaWidget(tester, WeekChart(days: days, goal: 2000));

    expect(
      find.bySemanticsLabel(RegExp('السعرات اليومية في آخر 7 أيام')),
      findsOneWidget,
    );
    expect(find.bySemanticsLabel(RegExp('1,240')), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('2,000')), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('—')), findsOneWidget);
    handle.dispose();
  });
}
