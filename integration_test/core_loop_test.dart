import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nesba_ai/core/di/injection_container.dart';
import 'package:nesba_ai/core/language/app_localizations_setup.dart';
import 'package:nesba_ai/core/service/shared_pref/shared_pref.dart';
import 'package:nesba_ai/core/style/theme/app_theme.dart';
import 'package:nesba_ai/core/widgets/calorie_ring.dart';
import 'package:nesba_ai/core/widgets/feedback/skeleton_card.dart';
import 'package:nesba_ai/core/widgets/rows/ledger_row.dart';
import 'package:nesba_ai/core/widgets/rows/macro_grid.dart';
import 'package:nesba_ai/features/log/ui/log_screen.dart';
import 'package:nesba_ai/features/log/ui/widgets/correction_sheet.dart';
import 'package:nesba_ai/features/log/ui/widgets/qty_stepper.dart';
import 'package:nesba_ai/features/log/ui/widgets/result_card.dart';
import 'package:nesba_ai/features/review/ui/review_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Copy-deck values from lang/ar.json — find.text matches the raw strings.
const String kDescription = 'بيض وتوست وعصير برتقال';
const String kAnalyzeCta = 'تحليل الوجبة';
const String kCtaDisabledReason = 'اوصف وجبتك أولًا';
const String kProgress1 = 'نقرأ وصف وجبتك…';
const String kCancel = 'إلغاء';
const String kEcho = '«بيض وتوست وعصير برتقال»';
const String kVerdictAcceptable = 'لا بأس بها';
const String kEstimateChip = 'تقديري';
const String kDisclaimer = 'تقديرات ذكاء اصطناعي — ليست استشارة طبية';
const String kDetailsToggle = 'التفاصيل';
const String kItemEgg = 'بيض مسلوق';
const String kItemToast = 'توست أسمر';
const String kItemJuice = 'عصير برتقال';
const String kDone = 'تم';
const String kEditedChip = 'مُعدّل';
const String kSaveCta = 'حفظ الوجبة';
const String kSavedSnackbar = 'أُضيفت إلى وجبات اليوم';
const String kUndo = 'تراجع';
const String kMealOats = 'شوفان بالحليب والموز';
const String kMealChicken = 'صدر دجاج مشوي مع أرز';
const String kMealSalad = 'سلطة خضراء بالفيتا';
const String kMealRemovedSnackbar = 'أُزيل شوفان بالحليب والموز — تراجع';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // Production injector minus Firebase — main() is never called here.
    await setupInjector();
  });

  // Design canvas 390x844 at dpr 1 — ScreenUtil scales stay 1:1 like the
  // device. setSurfaceSize is required by the live integration binding; the
  // view overrides drive MediaQuery so ScreenUtilInit reads the design size.
  Future<void> pumpNesba(
    WidgetTester tester,
    Widget child, {
    bool settle = true,
  }) async {
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(390, 844);
    await tester.binding.setSurfaceSize(const Size(390, 844));
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await SharedPref().instantiatePreferences();
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        builder: (_, _) => MaterialApp(
          locale: const Locale('ar'),
          supportedLocales: AppLocalizationsSetup.supportedLocales,
          localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
          theme: themeLight(),
          home: Scaffold(body: child),
        ),
      ),
    );
    await tester.pump();
    if (settle) {
      await tester.pumpAndSettle();
    }
  }

  // Log screen from the empty composer to the wired result card.
  Future<void> driveToResultCard(WidgetTester tester) async {
    await pumpNesba(tester, const LogScreen());
    await tester.enterText(find.byType(TextField), kDescription);
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, kAnalyzeCta));
    await tester.pump();
    // Mock analysis resolves after 2.5s — real time on this binding.
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  }

  // 1. «سجّل» from the empty description to the correction sheet.
  testWidgets('log: description → analysis → result card → correction sheet',
      (tester) async {
    await pumpNesba(tester, const LogScreen());

    // Empty field → CTA disabled with its declared reason (states §1.2-1).
    expect(find.text(kCtaDisabledReason), findsOneWidget);
    FilledButton cta = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, kAnalyzeCta),
    );
    expect(cta.onPressed, isNull);

    // Typing enables the CTA and drops the reason line.
    await tester.enterText(find.byType(TextField), kDescription);
    await tester.pump();
    expect(find.text(kCtaDisabledReason), findsNothing);
    cta = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, kAnalyzeCta),
    );
    expect(cta.onPressed, isNotNull);

    // Analyze → in-place progress: skeleton holds the footprint, rotating
    // line rides under it, cancel stays reachable. The rotating copy shows
    // twice by design — in the CTA progress row and under the skeleton.
    await tester.tap(find.widgetWithText(FilledButton, kAnalyzeCta));
    await tester.pump();
    expect(find.byType(SkeletonCard), findsOneWidget);
    expect(find.text(kProgress1), findsNWidgets(2));
    expect(find.text(kCancel), findsOneWidget);

    // Mock analysis lands after 2.5s → result card replaces the skeleton.
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.byType(SkeletonCard), findsNothing);
    expect(find.byType(ResultCard), findsOneWidget);
    expect(find.text(kEcho), findsOneWidget);
    expect(find.textContaining('~430'), findsOneWidget);
    expect(find.text(kVerdictAcceptable), findsOneWidget);
    expect(find.text(kEstimateChip), findsOneWidget);
    expect(find.text(kDisclaimer), findsOneWidget);

    // «التفاصيل» reveals the recognized items.
    await tester.ensureVisible(find.text(kDetailsToggle));
    await tester.pumpAndSettle();
    await tester.tap(find.text(kDetailsToggle));
    await tester.pumpAndSettle();
    expect(find.text(kItemEgg), findsOneWidget);
    expect(find.text(kItemToast), findsOneWidget);
    expect(find.text(kItemJuice), findsOneWidget);

    // Tapping the first item opens the correction sheet.
    await tester.ensureVisible(find.text(kItemEgg));
    await tester.pumpAndSettle();
    await tester.tap(find.text(kItemEgg));
    await tester.pumpAndSettle();
    expect(find.byType(CorrectionSheet), findsOneWidget);
    expect(find.byType(QtyStepper), findsOneWidget);
    expect(find.text('×2'), findsOneWidget);
  });

  // 2. Correction sheet: live stepper math, then «تم» lands on the card.
  testWidgets('sheet: «+» steps the multiplier live, «تم» commits to the card',
      (tester) async {
    await driveToResultCard(tester);

    await tester.ensureVisible(find.text(kDetailsToggle));
    await tester.pumpAndSettle();
    await tester.tap(find.text(kDetailsToggle));
    await tester.pumpAndSettle();

    // «عصير برتقال» starts at ×1 — stepping up walks ×1 → ×1.5 → ×2.
    await tester.ensureVisible(find.text(kItemJuice));
    await tester.pumpAndSettle();
    await tester.tap(find.text(kItemJuice));
    await tester.pumpAndSettle();
    expect(find.byType(CorrectionSheet), findsOneWidget);
    expect(find.text('×1'), findsOneWidget);

    // First «+» → ×1.5: item kcal 124→186, live meal total 430→492.
    await tester.tap(find.byIcon(Icons.add_outlined));
    await tester.pump();
    expect(find.text('×1.5'), findsOneWidget);
    expect(find.textContaining('186'), findsWidgets);
    expect(find.textContaining('492'), findsWidgets);

    // Second «+» → ×2: item 248, meal total 554.
    await tester.tap(find.byIcon(Icons.add_outlined));
    await tester.pump();
    expect(find.text('×2'), findsOneWidget);
    expect(find.textContaining('554'), findsWidgets);

    // «تم» commits — the card behind reflects the edit with the edited chip.
    await tester.tap(find.text(kDone));
    await tester.pumpAndSettle();
    expect(find.byType(CorrectionSheet), findsNothing);
    expect(find.textContaining('~554'), findsOneWidget);
    expect(find.text('248'), findsOneWidget);
    expect(find.text(kEditedChip), findsOneWidget);
  });

  // 3. Save morph: undo snackbar + ledger row, then undo removes the row.
  testWidgets('save: snackbar undo lands the ledger row, undo removes it',
      (tester) async {
    await driveToResultCard(tester);

    // 400ms mock save latency → saved state morphs the card out.
    await tester.ensureVisible(find.text(kSaveCta));
    await tester.pumpAndSettle();
    await tester.tap(find.text(kSaveCta));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();

    expect(find.text(kSavedSnackbar), findsOneWidget);
    expect(find.text(kUndo), findsOneWidget);
    expect(find.byType(ResultCard), findsNothing);
    expect(find.widgetWithText(LedgerRow, kDescription), findsOneWidget);

    // Undo deletes the same mealId and brings the card back as it was.
    await tester.tap(find.text(kUndo));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(LedgerRow, kDescription), findsNothing);
    expect(find.byType(ResultCard), findsOneWidget);
    expect(find.text(kSavedSnackbar), findsNothing);
  });

  // 4. Review gate: skeleton → day content → swipe delete → undo restores.
  testWidgets('review: skeleton → ring/macros/list → swipe delete → undo',
      (tester) async {
    // settle:false — the skeleton shimmer never lets pumpAndSettle finish.
    await pumpNesba(tester, const ReviewScreen(), settle: false);
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(SkeletonCard), findsOneWidget);

    // 600ms mock latency → day content: hero ring, macros, meals list.
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    expect(find.byType(SkeletonCard), findsNothing);
    expect(find.byType(CalorieRing), findsOneWidget);
    expect(find.byType(MacroGrid), findsOneWidget);
    expect(find.text(kMealOats), findsOneWidget);
    expect(find.text(kMealChicken), findsOneWidget);
    expect(find.text(kMealSalad), findsOneWidget);

    // RTL start-swipe (startToEnd = leftward) dismisses the first row.
    await tester.ensureVisible(find.text(kMealOats));
    await tester.pumpAndSettle();
    await tester.drag(find.text(kMealOats), const Offset(-320, 0));
    await tester.pumpAndSettle();
    expect(find.text(kMealOats), findsNothing);
    expect(find.text(kMealRemovedSnackbar), findsOneWidget);
    expect(find.text(kUndo), findsOneWidget);

    // Undo restores the row at its original position.
    await tester.tap(find.text(kUndo));
    await tester.pumpAndSettle();
    expect(find.text(kMealOats), findsOneWidget);
    expect(find.text(kMealRemovedSnackbar), findsNothing);
  });
}
