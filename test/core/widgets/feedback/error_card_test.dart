import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/core/widgets/feedback/error_card.dart';

import '../../../helpers/pump_app.dart';

void main() {
  const String title = 'استغرق التحليل وقتًا طويلًا';
  const String body = 'قد تكون الشبكة بطيئة أو الخدمة مزدحمة. وصفك باقٍ كما كتبته';

  testWidgets('renders icon, title, body and both actions on errorContainer',
      (WidgetTester tester) async {
    await pumpNesbaWidget(
      tester,
      ErrorCard(
        icon: Icons.cloud_off,
        title: title,
        body: body,
        actions: <(String, VoidCallback?)>[
          ('إعادة المحاولة', () {}),
          ('إلغاء', null),
        ],
      ),
    );

    final ColorScheme scheme =
        Theme.of(tester.element(find.byType(ErrorCard))).colorScheme;
    final Container root = tester.widget<Container>(
      find.descendant(
        of: find.byType(ErrorCard),
        matching: find.byType(Container),
      ),
    );
    expect((root.decoration! as BoxDecoration).color, scheme.errorContainer);

    expect(find.byIcon(Icons.cloud_off), findsOneWidget);
    expect(find.text(title), findsOneWidget);
    expect(find.text(body), findsOneWidget);
    expect(find.text('إعادة المحاولة'), findsOneWidget);
    expect(find.text('إلغاء'), findsOneWidget);
  });

  testWidgets('actions are pressable and callbacks fire',
      (WidgetTester tester) async {
    int retries = 0;
    await pumpNesbaWidget(
      tester,
      ErrorCard(
        icon: Icons.cloud_off,
        title: title,
        body: body,
        actions: <(String, VoidCallback?)>[
          ('إعادة المحاولة', () {
            retries++;
          }),
        ],
      ),
    );

    await tester.tap(find.text('إعادة المحاولة'));
    expect(retries, 1);
  });

  testWidgets('renders without an actions row when none are passed',
      (WidgetTester tester) async {
    await pumpNesbaWidget(tester, const ErrorCard(
      icon: Icons.cloud_off,
      title: title,
      body: body,
    ));

    expect(find.text(title), findsOneWidget);
    expect(find.byType(TextButton), findsNothing);
  });
}
