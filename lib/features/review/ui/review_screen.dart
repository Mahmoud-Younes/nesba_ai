import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/animations/animate_do.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/di/injection_container.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/core/widgets/calorie_ring.dart';
import 'package:nesba_ai/core/widgets/feedback/empty_state.dart';
import 'package:nesba_ai/core/widgets/feedback/skeleton_card.dart';
import 'package:nesba_ai/core/widgets/feedback/undo_snackbar.dart';
import 'package:nesba_ai/core/widgets/nes_app_bar.dart';
import 'package:nesba_ai/core/widgets/rows/macro_grid.dart';
import 'package:nesba_ai/features/review/logic/review_cubit.dart';
import 'package:nesba_ai/features/review/ui/widgets/meals_list.dart';
import 'package:nesba_ai/features/review/ui/widgets/segmented_day_week.dart';

/// S06 «راجع» frame (screen-specs §2.6): hero ring anchor + under/over
/// status row + macros + the full day meals list under the pinned
/// day/week switch.
class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ReviewCubit>()..load(),
      child: BlocBuilder<ReviewCubit, ReviewState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: NesAppBar(
              // The title follows the switch: «يومك» ↔ «أسبوعك» (§2.6).
              title: switch (state.mode) {
                ReviewMode.week =>
                  context.translate(LangKeys.reviewTitleWeek),
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
        SliverToBoxAdapter(child: _content(context, state)),
      ],
    );
  }

  Widget _content(BuildContext context, ReviewState state) {
    if (state.isLoading) {
      return _skeleton(context);
    }
    if (state.mode == ReviewMode.week) {
      return _weekPlaceholder(context);
    }
    if (state.meals.isEmpty) {
      return _dayEmpty(context, state);
    }
    return _dayContent(context, state);
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
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SkeletonCard(),
          SizedBox(height: 12.h),
          Container(
            height: 48.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: scheme.surfaceContainer,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ],
      ),
    );
  }

  // TODO(week-view): ticket #28 — the weekly chart/summary land there; the
  // declared week empty state keeps the switch honest meanwhile (§2.7).
  Widget _weekPlaceholder(BuildContext context) {
    return _fadeIn(
      context,
      500,
      Padding(
        padding: EdgeInsets.all(16.w),
        child: EmptyState(
          title: context.translate(LangKeys.emptyWeekTitle),
          body: context.translate(LangKeys.emptyWeekHint),
          ctaLabel: context.translate(LangKeys.emptyWeekCtaToday),
          onCta: () => context.read<ReviewCubit>().toggleMode(ReviewMode.day),
        ),
      ),
    );
  }

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
          // TODO(log): routes to the log gate when shell wiring lands (21).
          onCta: () {},
        ),
      ),
    );
  }

  Widget _dayContent(BuildContext context, ReviewState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.h),
          _fadeIn(context, 400, _hero(context, state)),
          SizedBox(height: 16.h),
          _fadeIn(context, 500, _macros(context, state)),
          SizedBox(height: 16.h),
          _fadeIn(context, 600, _mealsSection(context, state)),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  // Hero ring anchor + under/over status row — icon + text + semantic color
  // so color is never the only signal (§2.6).
  Widget _hero(BuildContext context, ReviewState state) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Map<String, dynamic> summary =
        state.summary ?? const <String, dynamic>{};
    final int consumed = summary['consumed'] as int? ?? 0;
    final int goal = summary['goal'] as int? ?? 0;
    final bool hasGoal = goal > 0;
    final bool isOver = hasGoal && consumed > goal;
    return Column(
      children: [
        Center(
          child: CalorieRing(
            consumed: consumed,
            goal: hasGoal ? goal : null,
            variant: CalorieRingVariant.hero,
            subtitleText: context.translate(
              hasGoal ? LangKeys.ringGoalSuffix : LangKeys.noGoal,
            ),
            semanticsLabel:
                _ringA11y(context, consumed, goal, hasGoal, isOver),
          ),
        ),
        SizedBox(height: 8.h),
        // TODO(copy-gap): under/over labels bake deck numbers («300») — a
        // {value} placeholder key is needed before real data feeds them.
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
            TextApp(
              text: context.translate(
                isOver ? LangKeys.overGoalLabel : LangKeys.underGoalLabel,
              ),
              theme: context.textStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeightHelper.medium,
                fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
                color: scheme.onSurface,
              ),
            ),
          ],
        ),
      ],
    );
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
    final String status = context.translate(
      isOver ? LangKeys.overGoalLabel : LangKeys.underGoalLabel,
    );
    return '${context.translate(LangKeys.ringLabel)}: $numbers $status';
  }

  // MacroGrid collapses to one column at ≥1.6 scaler internally (§1.5);
  // daily targets ride the summary map beside the current grams.
  Widget _macros(BuildContext context, ReviewState state) {
    final ({int protein, int carbs, int fat})? macros = state.macros;
    if (macros == null) return const SizedBox.shrink();
    final Map<String, dynamic> summary =
        state.summary ?? const <String, dynamic>{};
    return MacroGrid(
      protein: (
        current: formatCalories(macros.protein),
        target: formatCalories(summary['proteinGoal'] as int? ?? 0),
      ),
      carbs: (
        current: formatCalories(macros.carbs),
        target: formatCalories(summary['carbsGoal'] as int? ?? 0),
      ),
      fat: (
        current: formatCalories(macros.fat),
        target: formatCalories(summary['fatGoal'] as int? ?? 0),
      ),
    );
  }

  // «وجبات اليوم» + the full list (§2.6): grouped rows, sync badges,
  // start-aware swipe-to-delete with undo, tap → meal detail (ticket 18).
  Widget _mealsSection(BuildContext context, ReviewState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextApp(
          text: context.translate(LangKeys.mealsHeader),
          theme: context.textStyle.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeightHelper.semiBold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 8.h),
        MealsList(
          meals: state.meals,
          onMealTap: (_) {
            // TODO(meal-detail): view/edit route (ticket 18).
          },
          onDeleteMeal: (Map<String, dynamic> row) {
            context.read<ReviewCubit>().removeMeal(row);
            final String name = row['name'] as String? ?? '';
            final String base =
                context.translate(LangKeys.itemRemovedSnackbar);
            final String message = base
                .replaceAll('{العنصر}', name)
                .replaceAll('{Item}', name)
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
      ],
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SegmentedDayWeek(mode: mode, onChanged: onChanged),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _SegmentedHeader oldDelegate) =>
      oldDelegate.mode != mode;
}
