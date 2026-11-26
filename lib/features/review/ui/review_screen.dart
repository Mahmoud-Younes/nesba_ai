import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:nesba_ai/core/common/animations/animate_do.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/di/injection_container.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/helpers/spacing.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/routes/app_routes.dart';
import 'package:nesba_ai/core/style/fonts/app_type_scale.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/core/style/theme/app_radius.dart';
import 'package:nesba_ai/core/widgets/nes_screen_body.dart';
import 'package:nesba_ai/core/widgets/nes_section_card.dart';
import 'package:nesba_ai/core/widgets/calorie_ring.dart';
import 'package:nesba_ai/core/widgets/feedback/empty_state.dart';
import 'package:nesba_ai/core/widgets/feedback/error_card.dart';
import 'package:nesba_ai/core/widgets/feedback/skeleton_card.dart';
import 'package:nesba_ai/core/widgets/feedback/undo_snackbar.dart';
import 'package:nesba_ai/core/widgets/nes_app_bar.dart';
import 'package:nesba_ai/core/widgets/rows/macro_grid.dart';
import 'package:nesba_ai/core/widgets/rows/macro_row.dart';
import 'package:nesba_ai/features/review/data/models/week_summary.dart';
import 'package:nesba_ai/features/review/logic/review_cubit.dart';
import 'package:nesba_ai/features/review/ui/widgets/meals_list.dart';
import 'package:nesba_ai/features/review/ui/widgets/segmented_day_week.dart';
import 'package:nesba_ai/features/review/ui/widgets/week_chart.dart';

/// S06 «راجع» frame (screen-specs §2.6): hero ring anchor + under/over
/// status row + macros + the full day meals list under the pinned
/// day/week switch.
class ReviewScreen extends StatelessWidget {
  const ReviewScreen({this.onGoToLog, this.onRelogMeal, super.key});

  /// Shell-injected jump to the log gate (both empty-state CTAs).
  final VoidCallback? onGoToLog;

  /// G-12 «سجّلها تاني» — shell seeds the log draft with this meal.
  final ValueChanged<Map<String, dynamic>>? onRelogMeal;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ReviewCubit>()..load(),
      child: BlocBuilder<ReviewCubit, ReviewState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: NesAppBar(
              onSettingsTap: () async {
                await context.pushName(AppRoutes.settings);
                if (context.mounted) {
                  context.read<ReviewCubit>().load();
                }
              },
              // The title follows the switch: «يومك» ↔ «أسبوعك» (§2.6).
              title: switch (state.mode) {
                ReviewMode.week => context.translate(LangKeys.reviewTitleWeek),
                ReviewMode.day => context.translate(LangKeys.reviewTitleDay),
              },
            ),
            body: SafeArea(child: _body(context, state)),
          );
        },
      ),
    );
  }

  // Zone map (§2.6): pinned switch → ring + status → macros → meals list.
  Widget _body(BuildContext context, ReviewState state) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: _SegmentedHeader(
            mode: state.mode,
            onChanged: context.read<ReviewCubit>().toggleMode,
          ),
        ),
        SliverToBoxAdapter(
          // One measure for every branch — each used to carry its own
          // padding, which drifted between 12 and 16 depending on state.
          // scrollable: false because the CustomScrollView above already
          // owns the scroll.
          child: NesScreenBody(
            scrollable: false,
            child: _content(context, state),
          ),
        ),
      ],
    );
  }

  Widget _content(BuildContext context, ReviewState state) {
    if (state.isLoading) {
      return _skeleton(context);
    }
    if (state.mode == ReviewMode.week) {
      return _weekContent(context, state);
    }
    if (state.errorMessage != null) {
      return _errorState(context, state);
    }
    if (state.meals.isEmpty) {
      return _dayEmpty(context, state);
    }
    return _dayContent(context, state);
  }

  // states §1.5 review-day: error card + retry, previous cache stays below.
  Widget _errorState(BuildContext context, ReviewState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ErrorCard(
          icon: Icons.error_outline,
          title: context.translate(LangKeys.errServerTitle),
          body: context.translate(LangKeys.errServerBody),
          actions: <(String, VoidCallback)>[
            (
              context.translate(LangKeys.errOfflineAction),
              () => context.read<ReviewCubit>().load(),
            ),
          ],
        ),
        if (state.meals.isNotEmpty) ...<Widget>[
          verticalSpace(AppSpacing.s16),
          _mealsSection(context, state),
        ],
      ],
    );
  }

  // Skips the entrance animation when the OS asks for reduced motion.
  Widget _fadeIn(BuildContext context, int duration, Widget child) =>
      MediaQuery.disableAnimationsOf(context)
      ? child
      : CustomFadeInUp(duration: duration, child: child);

  // First read only (states §1.5 loading): card footprint for the ring +
  // one line for the macros row.
  Widget _skeleton(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SkeletonCard(),
        verticalSpace(AppSpacing.s12),
        Container(
          height: 48.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: scheme.surfaceContainer,
            borderRadius: BorderRadius.circular(AppRadius.medium.r),
          ),
        ),
      ],
    );
  }

  // S07 zones: chart → average ring → top/bottom rows → weekly macros.
  Widget _weekContent(BuildContext context, ReviewState state) {
    final WeekSummary? week = state.week;
    if (state.errorMessage != null && (week == null || week.isEmpty)) {
      return _weekError(context);
    }
    if (week == null || week.isEmpty) {
      return _weekEmpty(context);
    }
    final List<WeekDay> dataDays = week.days
        .where((WeekDay day) => day.hasData)
        .toList();
    final int average =
        (dataDays.fold<int>(0, (int sum, WeekDay day) => sum + day.kcal!) /
                dataDays.length)
            .round();
    final WeekDay top = dataDays.reduce(
      (WeekDay a, WeekDay b) => a.kcal! >= b.kcal! ? a : b,
    );
    final WeekDay bottom = dataDays.reduce(
      (WeekDay a, WeekDay b) => a.kcal! <= b.kcal! ? a : b,
    );
    final int goal = (state.summary?['goal'] as num? ?? 0).toInt();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (state.errorMessage != null) ...<Widget>[
          ErrorCard(
            icon: Icons.error_outline,
            title: context.translate(LangKeys.errServerTitle),
            body: context.translate(LangKeys.errServerBody),
            actions: <(String, VoidCallback)>[
              (
                context.translate(LangKeys.errOfflineAction),
                () => context.read<ReviewCubit>().load(),
              ),
            ],
          ),
          verticalSpace(AppSpacing.s16),
        ],
        _fadeIn(context, 400, WeekChart(days: week.days, goal: goal)),
        verticalSpace(AppSpacing.s16),
        _fadeIn(context, 500, _weekAverage(context, average, goal)),
        verticalSpace(AppSpacing.s16),
        _fadeIn(context, 600, _weekExtremes(context, top, bottom, goal)),
        verticalSpace(AppSpacing.s16),
        _fadeIn(context, 700, _weekMacros(context, week)),
      ],
    );
  }

  Widget _weekEmpty(BuildContext context) {
    return _fadeIn(
      context,
      500,
      EmptyState(
        title: context.translate(LangKeys.emptyWeekTitle),
        body: context.translate(LangKeys.emptyWeekHint),
        ctaLabel: context.translate(LangKeys.emptyWeekCtaToday),
        onCta: () => context.read<ReviewCubit>().toggleMode(ReviewMode.day),
        secondaryCtaLabel: context.translate(LangKeys.emptyWeekCtaLog),
        onSecondaryCta: onGoToLog,
      ),
    );
  }

  Widget _weekError(BuildContext context) {
    return ErrorCard(
      icon: Icons.error_outline,
      title: context.translate(LangKeys.errServerTitle),
      body: context.translate(LangKeys.errServerBody),
      actions: <(String, VoidCallback)>[
        (
          context.translate(LangKeys.errOfflineAction),
          () => context.read<ReviewCubit>().load(),
        ),
      ],
    );
  }

  Widget _weekAverage(BuildContext context, int average, int goal) {
    final bool hasGoal = goal > 0;
    final String line = hasGoal
        ? '${context.translate(LangKeys.weekAvgLabel)}: \u2066${formatCalories(average)}\u2069 ${context.translate(LangKeys.ringGoalSuffix).replaceAll('{value}', formatCalories(goal))}'
        : '${context.translate(LangKeys.weekAvgLabel)}: \u2066${formatCalories(average)}\u2069 · ${context.translate(LangKeys.noGoal)}';
    return Semantics(
      label: line,
      excludeSemantics: true,
      child: _weekCard(
        context,
        child: Row(
          children: <Widget>[
            CalorieRing(
              consumed: average,
              goal: hasGoal ? goal : null,
              variant: CalorieRingVariant.average,
              semanticsLabel: line,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: TextApp(
                text: line,
                theme: context.textStyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeightHelper.medium,
                  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // «أعلى يوم: الجمعة 2,140» / «أقل يوم: الثلاثاء 980» — two 48dp rows.
  Widget _weekExtremes(
    BuildContext context,
    WeekDay top,
    WeekDay bottom,
    int goal,
  ) {
    return _weekCard(
      context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _weekExtremeRow(
            context,
            icon: Icons.trending_up,
            labelKey: LangKeys.weekTopDay,
            day: top,
            goal: goal,
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          _weekExtremeRow(
            context,
            icon: Icons.trending_down,
            labelKey: LangKeys.weekBottomDay,
            day: bottom,
            goal: goal,
          ),
        ],
      ),
    );
  }

  Widget _weekExtremeRow(
    BuildContext context, {
    required IconData icon,
    required String labelKey,
    required WeekDay day,
    required int goal,
  }) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool over = goal > 0 && day.kcal! > goal;
    final String line =
        '${context.translate(labelKey)}: ${_dayName(context, day.date)} \u2066${formatCalories(day.kcal!)}\u2069';
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 20.r,
            color: over
                ? context.color.chartOverTarget!
                : context.color.chartUnderTarget!,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextApp(
              text: line,
              theme: context.textStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeightHelper.regular,
                fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
                color: scheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Weekly percentages, not daily grams — protein/carbs at 4 kcal/g, fat 9.
  Widget _weekMacros(BuildContext context, WeekSummary week) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final int proteinCal = week.proteinGrams * 4;
    final int carbsCal = week.carbsGrams * 4;
    final int fatCal = week.fatGrams * 9;
    final int totalCal = proteinCal + carbsCal + fatCal;
    String pct(int value) =>
        totalCal == 0 ? '0%' : '${(value / totalCal * 100).round()}%';
    return _weekCard(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextApp(
            text: context.translate(LangKeys.weekMacrosTitle),
            theme: context.textStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeightHelper.semiBold,
              color: scheme.onSurface,
            ),
          ),
          SizedBox(height: 12.h),
          MacroRow(
            proteinText: '\u2066${pct(proteinCal)}\u2069',
            carbsText: '\u2066${pct(carbsCal)}\u2069',
            fatText: '\u2066${pct(fatCal)}\u2069',
          ),
        ],
      ),
    );
  }

  // Kept as a named seam for the week zones; the shape itself is the
  // shared card now, so day and week cannot drift apart.
  Widget _weekCard(BuildContext context, {required Widget child}) =>
      NesSectionCard(child: child);

  String _dayName(BuildContext context, DateTime date) => DateFormat.E(
    Localizations.localeOf(context).toLanguageTag(),
  ).format(date);

  // Two distinct empties (states §1.5): first run vs a day with no meals —
  // no blame copy in either; both replace the day zones entirely.
  Widget _dayEmpty(BuildContext context, ReviewState state) {
    final bool firstRun = state.isFirstRun;
    return _fadeIn(
      context,
      500,
      Padding(
        padding: EdgeInsets.all(16.w),
        child: EmptyState(
          title: context.translate(
            firstRun ? LangKeys.emptyFirstRunTitle : LangKeys.emptyNoMealsTitle,
          ),
          body: context.translate(
            firstRun ? LangKeys.emptyFirstRunBody : LangKeys.emptyNoMealsBody,
          ),
          ctaLabel: context.translate(
            firstRun ? LangKeys.emptyFirstRunCta : LangKeys.emptyNoMealsCta,
          ),
          // The empty-day CTA jumps to the log gate.
          onCta: onGoToLog,
        ),
      ),
    );
  }

  Widget _dayContent(BuildContext context, ReviewState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _fadeIn(context, 400, _hero(context, state)),
        verticalSpace(AppSpacing.s16),
        _fadeIn(context, 500, _macros(context, state)),
        verticalSpace(AppSpacing.s16),
        _fadeIn(context, 600, _mealsSection(context, state)),
      ],
    );
  }

  // Hero ring anchor + under/over status row — icon + text + semantic color
  // so color is never the only signal (§2.6).
  Widget _hero(BuildContext context, ReviewState state) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Map<String, dynamic> summary =
        state.summary ?? const <String, dynamic>{};
    final int consumed = (summary['consumed'] as num? ?? 0).toInt();
    final int goal = (summary['goal'] as num? ?? 0).toInt();
    final bool hasGoal = goal > 0;
    final bool isOver = hasGoal && consumed > goal;
    // The ring is the day's anchor, so it gets the card rather than
    // floating on the background above a carded macro grid.
    return NesSectionCard(
      child: Column(
        children: [
          Center(
            child: CalorieRing(
              consumed: consumed,
              goal: hasGoal ? goal : null,
              variant: CalorieRingVariant.hero,
              subtitleText: hasGoal
                  ? context
                        .translate(LangKeys.ringGoalSuffix)
                        .replaceAll('{value}', formatCalories(goal))
                  : context.translate(LangKeys.noGoal),
              semanticsLabel: _ringA11y(
                context,
                consumed,
                goal,
                hasGoal,
                isOver,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isOver ? Icons.trending_up : Icons.trending_down,
                size: 20.r,
                color: isOver
                    ? context.color.chartOverTarget!
                    : context.color.chartUnderTarget!,
              ),
              SizedBox(width: 6.w),
              Flexible(
                child: TextApp(
                  text: _statusLine(context, consumed, goal, isOver),
                  theme: context.textStyle.copyWith(
                    fontSize: AppTypeScale.bodyMedium.sp,
                    fontWeight: FontWeightHelper.medium,
                    fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
                    color: scheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // «باقي اليوم: {value} سعرة» / «تجاوزت الهدف بـ {value} سعرة» — real
  // numbers replace the deck's {value} placeholder (no baked claims).
  String _statusLine(
    BuildContext context,
    int consumed,
    int goal,
    bool isOver,
  ) {
    final String template = context.translate(
      isOver ? LangKeys.overGoalLabel : LangKeys.underGoalLabel,
    );
    final int diff = isOver ? consumed - goal : goal - consumed;
    return template.replaceAll('{value}', formatCalories(diff));
  }

  // «السعرات: 1,240 من 2,000» + الحالة — numeric path bidi-isolated (§3.3).
  String _ringA11y(
    BuildContext context,
    int consumed,
    int goal,
    bool hasGoal,
    bool isOver,
  ) {
    final String numbers = hasGoal
        ? '\u2066${formatCalories(consumed)} / ${formatCalories(goal)}\u2069'
        : formatCalories(consumed);
    final String status = _statusLine(context, consumed, goal, isOver);
    return '${context.translate(LangKeys.ringLabel)}: $numbers $status';
  }

  // MacroGrid collapses to one column at ≥1.6 scaler internally (§1.5);
  // daily targets ride the summary map beside the current grams.
  Widget _macros(BuildContext context, ReviewState state) {
    final ({int protein, int carbs, int fat})? macros = state.macros;
    if (macros == null) return const SizedBox.shrink();
    final Map<String, dynamic> summary =
        state.summary ?? const <String, dynamic>{};
    return NesSectionCard(
      child: MacroGrid(
        protein: (
          current: formatCalories(macros.protein),
          target: formatCalories((summary['proteinGoal'] as num? ?? 0).toInt()),
        ),
        carbs: (
          current: formatCalories(macros.carbs),
          target: formatCalories((summary['carbsGoal'] as num? ?? 0).toInt()),
        ),
        fat: (
          current: formatCalories(macros.fat),
          target: formatCalories((summary['fatGoal'] as num? ?? 0).toInt()),
        ),
      ),
    );
  }

  // The full list (§2.6): MealsList owns the «وجبات اليوم» header, group
  // headers, sync badges, retry/delete swipes and undo (screen-side snackbar).
  Widget _mealsSection(BuildContext context, ReviewState state) {
    return NesSectionCard(
      // Heading above the card — MealsList used to draw it inline at a
      // weight that competed with its own group labels.
      title: context.translate(LangKeys.mealsHeader),
      child: MealsList(
        meals: state.meals,
        onMealTap: (_) {
          // TODO(meal-detail): view/edit route — needs its own ticket.
        },
        onRelogMeal: onRelogMeal,
        onRetrySync: (Map<String, dynamic> row) =>
            context.read<ReviewCubit>().retrySync(row),
        onDeleteMeal: (Map<String, dynamic> row) {
          context.read<ReviewCubit>().removeMeal(row);
          final String name = row['name'] as String? ?? '';
          final String message = context
              .translate(LangKeys.itemRemovedSnackbar)
              .replaceAll('{item}', name);
          ScaffoldMessenger.of(context).showSnackBar(
            UndoSnackbar.build(
              context,
              message: message,
              onUndo: () => context.read<ReviewCubit>().undoRemoveMeal(),
            ),
          );
        },
      ),
    );
  }
}

/// Pinned 48dp switch above the meals list (spec §2.6) — stays while the
/// ring/macros/list scroll under it.
class _SegmentedHeader extends SliverPersistentHeaderDelegate {
  const _SegmentedHeader({required this.mode, required this.onChanged});

  final ReviewMode mode;
  final ValueChanged<ReviewMode> onChanged;

  @override
  double get minExtent => 48.h;

  @override
  double get maxExtent => 48.h;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ColoredBox(
      color: scheme.surface,
      child: NesScreenBody(
        scrollable: false,
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.screenEdge.w,
        ),
        child: SegmentedDayWeek(mode: mode, onChanged: onChanged),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _SegmentedHeader oldDelegate) =>
      oldDelegate.mode != mode;
}
