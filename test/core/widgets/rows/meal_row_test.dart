import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/core/widgets/chips/sync_badge.dart';
import 'package:nesba_ai/core/widgets/rows/ledger_row.dart' show MealType;
import 'package:nesba_ai/core/widgets/rows/meal_row.dart';

import '../../../helpers/pump_app.dart';

void main() {
  // The chevron is mirrored manually in MealRow._chevron — chevron_right
  // never flips alone (spec §5 RTL). Assert on the IconData widget prop,
  // which is exact and not layout-dependent.
  testWidgets('ar locale (RTL): mirrored chevron + arabic copy',
      (WidgetTester tester) async {
    await pumpNesbaWidget(
      tester,
      MealRow(
        name: 'بيضتين',
        mealType: MealType.breakfast,
        timeText: '8:15 ص',
        kcalText: '140',
        onTap: () {},
      ),
    );

    expect(find.byType(MealRow), findsOneWidget);
    expect(find.text('بيضتين'), findsOneWidget);
    // mealSubLine: «label · \u2068time\u2069» with the FSI-isolated time.
    expect(find.text('فطار · \u20688:15 ص\u2069'), findsOneWidget);
    expect(find.text('140'), findsOneWidget);

    expect(find.byIcon(Icons.chevron_left), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right), findsNothing);
  });

  testWidgets('en locale (LTR): english copy + unmirrored chevron',
      (WidgetTester tester) async {
    await pumpNesbaWidget(
      tester,
      MealRow(
        name: 'Two eggs',
        mealType: MealType.breakfast,
        timeText: '8:15',
        kcalText: '140',
        onTap: () {},
      ),
      locale: const Locale('en'),
    );

    expect(find.text('Two eggs'), findsOneWidget);
    expect(find.text('Breakfast · \u20688:15\u2069'), findsOneWidget);
    expect(find.text('140'), findsOneWidget);

    expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    expect(find.byIcon(Icons.chevron_left), findsNothing);
  });

  // The failed-sync badge carries the longest deck copy; on a narrow row it
  // must shrink instead of pushing the flex past its boundary (RTL stripes).
  testWidgets('RTL: wide failed-sync badge fits a narrow row',
      (WidgetTester tester) async {
    await pumpNesbaWidget(
      tester,
      SizedBox(
        width: 320,
        child: MealRow(
          name: 'صدر دجاج مشوي مع أرز',
          mealType: MealType.lunch,
          timeText: '13:30 م',
          kcalText: '620',
          badge: SyncBadge(status: SyncStatus.failed, onRetry: () {}),
          onTap: () {},
        ),
      ),
    );

    expect(tester.takeException(), isNull);
  });
}
