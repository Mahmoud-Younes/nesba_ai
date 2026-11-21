import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/animations/animate_do.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/di/injection_container.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/app_localizations.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/routes/app_routes.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/core/style/theme/app_radius.dart';
import 'package:nesba_ai/core/widgets/calorie_ring.dart';
import 'package:nesba_ai/core/widgets/chips/example_chips.dart';
import 'package:nesba_ai/core/widgets/feedback/error_card.dart';
import 'package:nesba_ai/core/widgets/feedback/skeleton_card.dart';
import 'package:nesba_ai/core/widgets/feedback/undo_snackbar.dart';
import 'package:nesba_ai/core/widgets/nes_app_bar.dart';
import 'package:nesba_ai/core/widgets/rows/ledger_row.dart';
import 'package:nesba_ai/core/widgets/summary_strip.dart';
import 'package:nesba_ai/features/log/data/models/analysis_result.dart';
import 'package:nesba_ai/features/log/data/models/meal_item.dart';
import 'package:nesba_ai/features/log/logic/log_cubit.dart';
import 'package:nesba_ai/features/log/ui/widgets/analysis_footnote_line.dart';
import 'package:nesba_ai/features/log/ui/widgets/analysis_progress_line.dart';
import 'package:nesba_ai/features/log/ui/widgets/analyze_cta.dart';
import 'package:nesba_ai/features/log/ui/widgets/composer.dart';
import 'package:nesba_ai/features/log/ui/widgets/correction_sheet.dart';
import 'package:nesba_ai/features/log/ui/widgets/result_card.dart';

/// S01 «سجّل» frame (screen-specs §2.0 quad contract / §2.1 first-run)
/// through the S02/S03/S05 integration: waiting area, result card, save morph.
class LogScreen extends StatefulWidget {
  const LogScreen({this.onGoToReview, super.key});

  /// Shell-injected jump to the review gate (strip tap + «الكل» chip).
  final VoidCallback? onGoToReview;

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  /// Result captured when the chevron expanded the composer — a new result
  /// collapses it back (S03 default).
  AnalysisResult? _expandedForResult;

  /// savedMealId of the previous state — drives the save/undo side effects.
  String? _prevSavedMealId;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // Chevron override only holds while the result it was opened on is current.
  bool _chevronOpen(AnalysisResult? result) =>
      _expandedForResult != null && identical(result, _expandedForResult);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LogCubit>()..loadTodayMeals(),
      child: BlocBuilder<LogCubit, LogState>(
        builder: (context, state) {
          return BlocListener<LogCubit, LogState>(
            listener: (context, state) => _onStateChanged(context, state),
            child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              appBar: NesAppBar(
                onSettingsTap: () => context.pushName(AppRoutes.settings),
              ),
              body: SafeArea(child: _body(context, state)),
            ),
          );
        },
      ),
    );
  }

  // Save/undo side effects (§2.5 steps 4+6): when the save lands the composer
  // resets empty (the cubit already cleared the description), and when the
  // undo lands the card returns with its text back in the field.
  void _onStateChanged(BuildContext context, LogState state) {
    final LogCubit cubit = context.read<LogCubit>();
    if (_prevSavedMealId == null && state.savedMealId != null) {
      _expandedForResult = null;
      _controller.clear();
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          UndoSnackbar.build(
            context,
            message: context.translate(LangKeys.saveSnackbar),
            onUndo: cubit.undoSave,
          ),
        );
    } else if (_prevSavedMealId != null &&
        state.savedMealId == null &&
        state.status == LogStatus.result) {
      final String text = state.result?.descriptionEcho ?? '';
      _controller
        ..text = text
        ..selection = TextSelection.collapsed(offset: text.length);
    }
    _prevSavedMealId = state.savedMealId;
  }

  // Quad contract (§2.0): strip (A) → composer (B) → result (C) → ledger (D).
  Widget _body(BuildContext context, LogState state) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _summaryStrip(context, state),
          SizedBox(height: 16.h),
          _composerSection(context, state),
          SizedBox(height: 16.h),
          _resultArea(context, state),
          SizedBox(height: 16.h),
          // First-run: no empty ledger block — dead space is banned (§2.1).
          if (state.todayMeals.isNotEmpty) _miniLedger(context, state),
        ],
      ),
    );
  }

  // Skips the entrance animation when the OS asks for reduced motion.
  Widget _fadeIn(BuildContext context, int duration, Widget child) =>
      MediaQuery.disableAnimationsOf(context)
      ? child
      : CustomFadeInUp(duration: duration, child: child);

  // (A) Daily strip — count-up rides consumedKcal changes (§2.5 step 5);
  // instant swap on reduced-motion.
  Widget _summaryStrip(BuildContext context, LogState state) {
    Widget strip(double consumed) => SummaryStrip(
      consumed: consumed.round(),
      goal: state.goalKcal,
      noGoalText: context.translate(LangKeys.noGoal),
      // TODO(copy-gap): strip status copy («فاضل 760») has no format key in
      // the deck — gap logged with the summary-strip report (§2.1 CD-06).
      statusText: null,
      semanticsLabel:
          '${context.translate(LangKeys.ringLabel)}: \u2066${formatCalories(state.consumedKcal)} / ${formatCalories(state.goalKcal)}\u2069',
      // Strip tap jumps to the review gate (S06).
      onTap: widget.onGoToReview,
    );
    if (MediaQuery.disableAnimationsOf(context)) {
      return _fadeIn(context, 400, strip(state.consumedKcal.toDouble()));
    }
    return _fadeIn(
      context,
      400,
      TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: state.consumedKcal.toDouble()),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
        builder: (_, double value, _) => strip(value),
      ),
    );
  }

  // (B) Composer first (§2.0): expanded in draft, stays expanded and editable
  // while analyzing (§2.2) and after a save (§2.5 step 6); collapsed once a
  // result lands, example chips in first-run, CTA kept above the keyboard.
  Widget _composerSection(BuildContext context, LogState state) {
    final LogCubit cubit = context.read<LogCubit>();
    final bool isExpanded =
        state.status == LogStatus.analyzing ||
        state.status == LogStatus.saved ||
        (state.status == LogStatus.draft && state.result == null) ||
        // First-run timeout has no result to collapse onto — the field
        // stays live for «إعادة المحاولة» (§2.7 timeout path).
        (state.isTimeout && state.result == null) ||
        _chevronOpen(state.result);
    final bool showChips = state.result == null || state.savedMealId != null;
    return _fadeIn(
      context,
      500,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Composer(
            controller: _controller,
            focusNode: _focusNode,
            isExpanded: isExpanded,
            onChanged: cubit.descriptionChanged,
            onExpand: state.result == null
                ? null
                : () => setState(() => _expandedForResult = state.result),
            onClear: () {
              _controller.clear();
              cubit.descriptionChanged('');
            },
            showFirstRunHint: state.result == null && state.todayMeals.isEmpty,
          ),
          if (showChips) ...[
            SizedBox(height: 12.h),
            ExampleChips(
              examples: <String>[
                context.translate(LangKeys.exampleMeal1),
                context.translate(LangKeys.exampleMeal2),
                context.translate(LangKeys.exampleMeal3),
              ],
              // Chip fills the field, enables the CTA and refocuses (§2.1).
              onExampleTap: (String example) {
                _controller
                  ..text = example
                  ..selection = TextSelection.collapsed(offset: example.length);
                cubit.descriptionChanged(example);
                _focusNode.requestFocus();
              },
            ),
          ],
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.viewInsetsOf(context).bottom,
            ),
            child: AnalyzeCTA(
              status: _ctaStatus(state),
              progressText: _progressText(context, state.progressStep),
              // TODO(copy): spec §2.3 renames the CTA to `re_analyze` in
              // result/edit mode — AnalyzeCTA has no label parameter yet;
              // until one lands, «إعادة التحليل» rides the stale notice's
              // action inside the card (ResultCard.onReanalyze).
              onAnalyze: () {
                // A new analysis forfeits any pending undo window.
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                cubit.startAnalysis();
              },
              onCancel: cubit.cancelAnalysis,
            ),
          ),
        ],
      ),
    );
  }

  // Empty field → disabled with the declared reason (states §1.2-1).
  AnalyzeCtaStatus _ctaStatus(LogState state) {
    if (state.status == LogStatus.analyzing) {
      return AnalyzeCtaStatus.progress;
    }
    if (state.description.trim().isNotEmpty) {
      return AnalyzeCtaStatus.enabled;
    }
    return AnalyzeCtaStatus.disabled;
  }

  // Rotating line per ticker step (deck analysis_progress_1..3, ≈2.5s each).
  String _progressText(BuildContext context, int step) => switch (step) {
    2 => context.translate(LangKeys.analysisProgress2),
    3 => context.translate(LangKeys.analysisProgress3),
    _ => context.translate(LangKeys.analysisProgress1),
  };

  // (C) Result slot (§2.2/§2.3/§2.5): skeleton while analyzing, timeout card
  // alone when nothing survived, wired ResultCard with the save morph — the
  // saved card slides-fades out while its slot closes (~300ms, instant on
  // reduced-motion).
  Widget _resultArea(BuildContext context, LogState state) {
    if (state.status == LogStatus.analyzing) {
      return _fadeIn(context, 600, _analysisWaitColumn(state));
    }
    if (state.isTimeout && state.result == null) {
      return _fadeIn(context, 600, _timeoutCard(context));
    }
    final AnalysisResult? result = state.result;
    if (result == null) return const SizedBox.shrink();
    final bool reduceMotion = MediaQuery.disableAnimationsOf(context);
    final Duration morphDuration = reduceMotion
        ? Duration.zero
        : const Duration(milliseconds: 300);
    return _fadeIn(
      context,
      600,
      AnimatedSize(
        duration: morphDuration,
        curve: Curves.easeInOut,
        alignment: AlignmentDirectional.topCenter,
        child: AnimatedSwitcher(
          duration: morphDuration,
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (Widget child, Animation<double> animation) =>
              _morphTransition(context, child, animation),
          child: state.savedMealId == null
              ? _resultCard(context, state, result)
              : const SizedBox.shrink(key: ValueKey<String>('log-saved-slot')),
        ),
      ),
    );
  }

  // While analyzing (§2.2): skeleton holds the card's footprint so the layout
  // never jumps; the rotating line + timing footnote ride under it. The
  // composer above stays expanded and editable the whole time.
  Widget _analysisWaitColumn(LogState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SkeletonCard(),
        SizedBox(height: 8.h),
        AnalysisProgressLine(progressStep: state.progressStep),
        SizedBox(height: 4.h),
        AnalysisFootnoteLine(elapsedSeconds: state.elapsedSeconds),
      ],
    );
  }

  // Timeout with nothing to keep (first analysis) — the card alone; with an
  // old result the ResultCard stacks the same card above it (states §1.3).
  Widget _timeoutCard(BuildContext context) {
    // TODO(copy): err_timeout_actions is one combined «إعادة المحاولة /
    // إلغاء» label and there are no split retry/cancel keys yet — actions
    // stay empty until the deck splits the key (ResultCard precedent).
    return ErrorCard(
      icon: Icons.schedule,
      title: context.translate(LangKeys.errTimeoutTitle),
      body: context.translate(LangKeys.errTimeoutBody),
    );
  }

  // S05 morph leg (~300ms): the outgoing card slides toward the ledger while
  // fading (the tween runs in reverse on exit); children swap instantly when
  // animations are disabled.
  Widget _morphTransition(
    BuildContext context,
    Widget child,
    Animation<double> animation,
  ) {
    if (MediaQuery.disableAnimationsOf(context)) return child;
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.35), end: Offset.zero)
            .animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
        child: child,
      ),
    );
  }

  // S03 result card, fully wired to the state and the cubit callbacks.
  Widget _resultCard(
    BuildContext context,
    LogState state,
    AnalysisResult result,
  ) {
    final LogCubit cubit = context.read<LogCubit>();
    return ResultCard(
      key: const ValueKey<String>('log-result-card'),
      result: result,
      isExpanded: state.isDetailsExpanded,
      isStale: state.isStale,
      isTimeout: state.isTimeout,
      showDisclaimer: state.showDisclaimer,
      onToggleExpand: cubit.toggleDetailsExpanded,
      onSaveMeal: cubit.saveMeal,
      onEditDescription: () => _editDescription(result),
      onItemTap: (MealItem item) => _openCorrectionSheet(context, item),
      // TODO(swaps): add-item flow lands with its own task — no-op for now.
      onAddItem: () {},
      // TODO(swaps): teaser deep-links to S09 meal-context swaps — no-op.
      onTeaserTap: () {},
      onReanalyze: cubit.reAnalyze,
      onKeep: cubit.keepResult,
      keepLabel: context.translate(LangKeys.staleKeepAction),
      kcalUnitText: _kcalUnitText(context),
      macroUnitText: _macroUnitText(context),
    );
  }

  // «عدّل الوصف» (§2.3): the text goes back to the field untouched — expand,
  // focus, cursor at the end; the CTA flips to re_analyze from here.
  void _editDescription(AnalysisResult result) {
    setState(() => _expandedForResult = result);
    _controller.selection = TextSelection.collapsed(
      offset: _controller.text.length,
    );
    _focusNode.requestFocus();
  }

  // S04 (§2.4): the sheet owns the live math; the cubit mirrors every change
  // into the state so the card behind it updates without waiting for «تم».
  void _openCorrectionSheet(BuildContext context, MealItem item) {
    final LogCubit cubit = context.read<LogCubit>();
    final AnalysisResult result = cubit.state.result!;
    CorrectionSheet.show(
      context,
      item: item,
      mealBaseKcal: result.kcal - item.kcal,
      mealProteinGrams: result.proteinGrams,
      mealCarbsGrams: result.carbsGrams,
      mealFatGrams: result.fatGrams,
      doneLabel: _doneLabel(context),
      kcalUnitText: _kcalUnitText(context),
      mealTotalLabel: _mealTotalLabel(context),
      macroUnitText: _macroUnitText(context),
      onApply: cubit.applyItemCorrection,
      onLiveChange: cubit.applyItemCorrection,
      // TODO(swaps): add-item flow lands with its own task — button disabled.
      onAddItem: null,
      onDelete: () {
        cubit.removeItem(item);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            UndoSnackbar.build(
              context,
              message: _itemRemovedMessage(context, item.name),
              onUndo: cubit.undoRemoveItem,
            ),
          );
      },
    );
  }

  // TODO(copy): standalone «تم»/«سعرة»/«جم»/«إجمالي الوجبة» keys are missing
  // from the deck — locale literals passed in until the deck owner adds them
  // (SummaryStrip.noGoalText precedent).
  bool _isEn(BuildContext context) => AppLocalizations.of(context)!.isEnLocale;

  String _kcalUnitText(BuildContext context) =>
      _isEn(context) ? 'kcal' : 'سعرة';

  String _macroUnitText(BuildContext context) => _isEn(context) ? 'g' : 'جم';

  String _doneLabel(BuildContext context) => _isEn(context) ? 'Done' : 'تم';

  String _mealTotalLabel(BuildContext context) =>
      _isEn(context) ? 'Meal total' : 'إجمالي الوجبة';

  // G-09: the deck bakes the placeholder into the copy («أُزيل {العنصر} —
  // تراجع» / "{Item} removed — Undo") — replaced manually here.
  String _itemRemovedMessage(BuildContext context, String itemName) {
    final String template = context.translate(LangKeys.itemRemovedSnackbar);
    return template
        .replaceAll('{العنصر}', itemName)
        .replaceAll('{Item}', itemName)
        .replaceAll('{item}', itemName);
  }

  // (D) Mini ledger — newest two rows (the row just saved lands on top,
  // §2.5 step 3), total + «الكل» chip (§2.0-D); hidden when the day has no
  // meals (§2.1).
  Widget _miniLedger(BuildContext context, LogState state) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final List<Map<String, dynamic>> rows = state.todayMeals;
    final List<Map<String, dynamic>> topRows = rows.length <= 2
        ? rows
        : rows.sublist(0, 2);
    return _fadeIn(
      context,
      700,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextApp(
            text: context.translate(LangKeys.logLedgerTitle),
            theme: context.textStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeightHelper.semiBold,
              color: scheme.onSurface,
            ),
          ),
          SizedBox(height: 8.h),
          for (final Map<String, dynamic> row in topRows)
            _ledgerRow(context, state, row),
          Row(
            children: [
              Expanded(
                child: TextApp(
                  text: context.translate(LangKeys.logLedgerTotal),
                  theme: context.textStyle.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeightHelper.medium,
                    fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
                    color: scheme.onSurface,
                  ),
                ),
              ),
              // «الكل» jumps to the review gate (S06).
              ActionChip(
                onPressed: widget.onGoToReview,
                side: BorderSide(color: scheme.outline),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.small.r),
                ),
                materialTapTargetSize: MaterialTapTargetSize.padded,
                label: TextApp(
                  text: context
                      .translate(LangKeys.ledgerAllChip)
                      .replaceAll('{count}', '${rows.length}'),
                  theme: context.textStyle.copyWith(
                    fontSize: 12.sp,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // The row saved in this session fades-slides in on top of the ledger with
  // the same ~300ms morph leg (§2.5 steps 2-3); instant on reduced-motion.
  Widget _ledgerRow(
    BuildContext context,
    LogState state,
    Map<String, dynamic> row,
  ) {
    final Widget rowWidget = LedgerRow(
      name: row['name'] as String? ?? '',
      mealType: _mealTypeFor(row),
      timeText: row['time'] as String? ?? '',
      kcalText: formatCalories(row['kcal'] as int? ?? 0),
    );
    final String? savedMealId = state.savedMealId;
    if (savedMealId == null || row['id'] != savedMealId) {
      return rowWidget;
    }
    return AnimatedSwitcher(
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) =>
          _morphTransition(context, child, animation),
      child: KeyedSubtree(key: ValueKey<String>(savedMealId), child: rowWidget),
    );
  }

  // Mock rows carry no meal type yet — contract field `type` falls back to
  // breakfast until the repo ships it.
  MealType _mealTypeFor(Map<String, dynamic> row) => switch (row['type']) {
    'lunch' => MealType.lunch,
    'dinner' => MealType.dinner,
    'snack' => MealType.snack,
    _ => MealType.breakfast,
  };
}
