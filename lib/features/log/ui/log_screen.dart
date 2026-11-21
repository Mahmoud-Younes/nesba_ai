import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/animations/animate_do.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/di/injection_container.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/core/style/theme/app_radius.dart';
import 'package:nesba_ai/core/widgets/calorie_ring.dart';
import 'package:nesba_ai/core/widgets/chips/example_chips.dart';
import 'package:nesba_ai/core/widgets/nes_app_bar.dart';
import 'package:nesba_ai/core/widgets/rows/ledger_row.dart';
import 'package:nesba_ai/core/widgets/summary_strip.dart';
import 'package:nesba_ai/features/log/data/models/analysis_result.dart';
import 'package:nesba_ai/features/log/logic/log_cubit.dart';
import 'package:nesba_ai/features/log/ui/widgets/analyze_cta.dart';
import 'package:nesba_ai/features/log/ui/widgets/composer.dart';

/// S01 «سجّل» frame (screen-specs §2.0 quad contract / §2.1 first-run).
class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  /// Result captured when the chevron expanded the composer — a new result
  /// collapses it back (S03 default).
  AnalysisResult? _expandedForResult;

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
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: NesAppBar(
              // TODO(settings): wire the settings route when it ships.
              onSettingsTap: () {},
            ),
            body: SafeArea(child: _body(context, state)),
          );
        },
      ),
    );
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

  // (A) Daily strip — numbers path only; status copy has no format key yet.
  Widget _summaryStrip(BuildContext context, LogState state) {
    return _fadeIn(
      context,
      400,
      SummaryStrip(
        consumed: state.consumedKcal,
        goal: state.goalKcal,
        noGoalText: context.translate(LangKeys.noGoal),
        // TODO(copy-gap): strip status copy («فاضل 760») has no format key in
        // the deck — gap logged with the summary-strip report (§2.1 CD-06).
        statusText: null,
        semanticsLabel:
            '${context.translate(LangKeys.ringLabel)}: \u2066${formatCalories(state.consumedKcal)} / ${formatCalories(state.goalKcal)}\u2069',
        // TODO(review): strip tap opens review/day (S06) — not wired yet.
        onTap: () {},
      ),
    );
  }

  // (B) Composer first (§2.0): expanded in draft, collapsed once a result
  // lands, example chips in first-run, CTA kept above the keyboard.
  Widget _composerSection(BuildContext context, LogState state) {
    final LogCubit cubit = context.read<LogCubit>();
    final bool isExpanded =
        (state.status == LogStatus.draft && state.result == null) ||
            _chevronOpen(state.result);
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
          if (state.result == null) ...[
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
            padding:
                EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
            child: AnalyzeCTA(
              status: _ctaStatus(state),
              progressText: _progressText(context, state.progressStep),
              onAnalyze: cubit.startAnalysis,
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

  // (C) Result slot — same fixed height while loading and with a card so the
  // layout never jumps; both are filled by the integration task.
  Widget _resultArea(BuildContext context, LogState state) {
    if (state.status == LogStatus.analyzing) {
      // TODO(loading-widgets): skeleton card lands at integration (S02, §2.2).
      return _fadeIn(context, 600, SizedBox(height: 272.h));
    }
    if (state.result != null) {
      // TODO(result-card): collapsed analysis card lands at integration
      // (S03, §2.3).
      return _fadeIn(context, 600, SizedBox(height: 272.h));
    }
    return const SizedBox.shrink();
  }

  // (D) Mini ledger — capped to the last two rows, total + «الكل» chip
  // (§2.0-D); hidden entirely when the day has no meals (§2.1).
  Widget _miniLedger(BuildContext context, LogState state) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final List<Map<String, dynamic>> rows = state.todayMeals;
    final List<Map<String, dynamic>> lastRows =
        rows.length <= 2 ? rows : rows.sublist(rows.length - 2);
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
          for (final Map<String, dynamic> row in lastRows)
            LedgerRow(
              name: row['name'] as String? ?? '',
              mealType: _mealTypeFor(row),
              timeText: row['time'] as String? ?? '',
              kcalText: formatCalories(row['kcal'] as int? ?? 0),
            ),
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
              // TODO(review): «الكل» opens the full day ledger (S06) — not wired.
              ActionChip(
                onPressed: () {},
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

  // Mock rows carry no meal type yet — contract field `type` falls back to
  // breakfast until the repo ships it.
  MealType _mealTypeFor(Map<String, dynamic> row) => switch (row['type']) {
        'lunch' => MealType.lunch,
        'dinner' => MealType.dinner,
        'snack' => MealType.snack,
        _ => MealType.breakfast,
      };
}
