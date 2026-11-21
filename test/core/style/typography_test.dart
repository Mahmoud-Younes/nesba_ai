// Pins the base typography wiring — the bodyMedium blocker stays fixed.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/style/fonts/font_family_helper.dart';
import '../../helpers/pump_app.dart';

void main() {
  testWidgets('context.textStyle rides the localized Plex family with zero tracking',
      (WidgetTester tester) async {
    TextStyle? base;
    await pumpNesbaWidget(
      tester,
      Builder(
        builder: (BuildContext context) {
          base = context.textStyle;
          return const SizedBox.shrink();
        },
      ),
    );
    expect(base, isNotNull);
    expect(
      base!.fontFamily,
      anyOf(
        FontFamilyHelper.ibmPlexSansArabic,
        FontFamilyHelper.ibmPlexSans,
      ),
    );
    expect(base!.letterSpacing, 0);
    expect(
      base!.fontFamilyFallback,
      contains(FontFamilyHelper.ibmPlexSansArabic),
    );
  });
}
