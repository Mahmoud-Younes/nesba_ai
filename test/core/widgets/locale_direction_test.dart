import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('en locale renders the english copy in an ltr directionality',
      (WidgetTester tester) async {
    await pumpNesbaWidget(
      tester,
      Builder(
        builder: (BuildContext context) => Center(
          child: TextApp(
            text: 'Daily summary',
            theme: context.textStyle.copyWith(fontSize: 14),
          ),
        ),
      ),
      locale: const Locale('en'),
    );

    expect(find.text('Daily summary'), findsOneWidget);
    expect(
      Directionality.of(tester.element(find.text('Daily summary'))),
      TextDirection.ltr,
    );
    expect(find.text('ملخص اليوم'), findsNothing);
  });
}
