import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/features/swaps/ui/widgets/swap_pair_card.dart';

import '../../../helpers/pump_app.dart';

void main() {
  testWidgets('savings line shows the pair delta, never "null"',
      (WidgetTester tester) async {
    await pumpNesbaWidget(
      tester,
      SwapPairCard(
        pair: const <String, dynamic>{
          'original_name': 'Full-fat shakshuka',
          'original_kcal': 480,
          'alt_name': 'Low-fat shakshuka',
          'alt_kcal': 290,
          'savings': 190,
          'hasFit': true,
        },
        isBookmarked: false,
        onSwap: () {},
        onBookmark: () {},
      ),
      locale: const Locale('en'),
    );

    expect(find.text('Saves 190 kcal'), findsOneWidget);
    expect(find.text('null'), findsNothing);
  });
}
