import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesba_ai/core/widgets/chips/sync_badge.dart';

import '../../../helpers/pump_app.dart';

void main() {
  const String okLabel = 'مُزامَنة';
  const String pendingLabel = 'بانتظار المزامنة';
  const String failedLabel = 'تعذّرت المزامنة — المس لإعادة المحاولة';

  testWidgets('ok and pending paint secondaryContainer with their labels',
      (WidgetTester tester) async {
    for (final (SyncStatus status, String label) in <(SyncStatus, String)>[
      (SyncStatus.ok, okLabel),
      (SyncStatus.pending, pendingLabel),
    ]) {
      await pumpNesbaWidget(tester, SyncBadge(status: status));

      final ColorScheme scheme =
          Theme.of(tester.element(find.byType(SyncBadge))).colorScheme;
      final Container container = tester.widget<Container>(
        find.descendant(
          of: find.byType(SyncBadge),
          matching: find.byType(Container),
        ),
      );
      expect(
        (container.decoration! as BoxDecoration).color,
        scheme.secondaryContainer,
        reason: 'SyncStatus.$status must use secondaryContainer',
      );
      expect(find.text(label), findsOneWidget,
          reason: 'SyncStatus.$status localized label');
    }
  });

  testWidgets('failed paints errorContainer and retries on tap',
      (WidgetTester tester) async {
    int retries = 0;
    // The FlutterTest font advances a full square per glyph (~2x the real
    // IBM Plex metrics), so the long failed copy cannot fit 390dp unwrapped;
    // the horizontal scroll just gives the badge its natural width.
    await pumpNesbaWidget(
      tester,
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SyncBadge(status: SyncStatus.failed, onRetry: () => retries++),
      ),
    );

    final ColorScheme scheme =
        Theme.of(tester.element(find.byType(SyncBadge))).colorScheme;
    // failed + onRetry renders the tappable Material surface.
    final Material material = tester.widget<Material>(
      find.descendant(
        of: find.byType(SyncBadge),
        matching: find.byType(Material),
      ),
    );
    expect(material.color, scheme.errorContainer);
    expect(find.text(failedLabel), findsOneWidget);

    await tester.tap(find.text(failedLabel));
    expect(retries, 1);
  });

  testWidgets('failed without onRetry stays a static badge',
      (WidgetTester tester) async {
    // Same test-font room as above for the long failed copy.
    await pumpNesbaWidget(
      tester,
      const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SyncBadge(status: SyncStatus.failed),
      ),
    );

    final ColorScheme scheme =
        Theme.of(tester.element(find.byType(SyncBadge))).colorScheme;
    // No InkWell surface — falls back to the plain container.
    final Container container = tester.widget<Container>(
      find.descendant(
        of: find.byType(SyncBadge),
        matching: find.byType(Container),
      ),
    );
    expect(
      (container.decoration! as BoxDecoration).color,
      scheme.errorContainer,
    );
    expect(
      find.descendant(
        of: find.byType(SyncBadge),
        matching: find.byType(InkWell),
      ),
      findsNothing,
    );
    expect(
      find.descendant(
        of: find.byType(SyncBadge),
        matching: find.byType(Material),
      ),
      findsNothing,
    );
  });
}
