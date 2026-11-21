import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/core/widgets/calorie_ring.dart';
import 'package:nesba_ai/core/widgets/chips/sync_badge.dart';
import 'package:nesba_ai/core/widgets/rows/ledger_row.dart';
import 'package:nesba_ai/core/widgets/rows/meal_row.dart';

/// «وجبات اليوم» — the only full meals list (S06 §2.6): meals_header +
/// mock-ordered group headers + MealRow rows with sync badges, start-swipe
/// delete and an optional quick re-log action (G-12).
class MealsList extends StatelessWidget {
  const MealsList({
    required this.meals,
    required this.onMealTap,
    required this.onDeleteMeal,
    this.onRelogMeal,
    super.key,
  });

  /// Mock-shaped rows: id/name/kcal/time/type + groupLabel, `sync` in
  /// {ok, pending, failed} — defaults to ok.
  final List<Map<String, dynamic>> meals;

  /// Row tap → meal detail route (TODO on the screen side).
  final ValueChanged<Map<String, dynamic>> onMealTap;

  /// Dismiss (swipe delete) — undo snackbar is the screen's responsibility.
  final ValueChanged<Map<String, dynamic>> onDeleteMeal;

  /// Quick «سجّلها تاني» (G-12) — replay icon is hidden when null.
  final ValueChanged<Map<String, dynamic>>? onRelogMeal;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final List<Widget> children = <Widget>[
      TextApp(
        text: context.translate(LangKeys.mealsHeader),
        theme: context.textStyle.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeightHelper.semiBold,
          color: scheme.onSurface,
        ),
      ),
      SizedBox(height: 8.h),
    ];
    int index = 0;
    bool firstGroup = true;
    for (final MapEntry<String, List<Map<String, dynamic>>> group
        in _groupByLabel(meals).entries) {
      if (!firstGroup) children.add(SizedBox(height: 12.h));
      firstGroup = false;
      children.add(
        TextApp(
          text: group.key,
          theme: context.textStyle.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeightHelper.regular,
            color: scheme.onSurfaceVariant,
          ),
        ),
      );
      children.add(SizedBox(height: 8.h));
      for (final Map<String, dynamic> row in group.value) {
        children.add(_mealItem(context, row, index));
        index++;
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  // Insertion-ordered grouping — order rides the mock order (spec §2.6).
  Map<String, List<Map<String, dynamic>>> _groupByLabel(
    List<Map<String, dynamic>> meals,
  ) {
    final Map<String, List<Map<String, dynamic>>> groups =
        <String, List<Map<String, dynamic>>>{};
    for (final Map<String, dynamic> row in meals) {
      groups
          .putIfAbsent(
            row['groupLabel'] as String? ?? '',
            () => <Map<String, dynamic>>[],
          )
          .add(row);
    }
    return groups;
  }

  // MealRow + sync badge in a start-swipe Dismissible; the re-log icon rides
  // the row end when wired. Row separators ride MealRow's built-in divider.
  Widget _mealItem(BuildContext context, Map<String, dynamic> row, int index) {
    final Widget rowWidget = MealRow(
      name: row['name'] as String? ?? '',
      mealType: _mealTypeFor(row),
      timeText: row['time'] as String? ?? '',
      kcalText: formatCalories(row['kcal'] as int? ?? 0),
      badge: SyncBadge(status: _syncFor(row)),
      onTap: () => onMealTap(row),
    );
    final Widget? relog = _relogAction(context, row);
    final Widget content = relog == null
        ? rowWidget
        : Row(children: <Widget>[Expanded(child: rowWidget), relog]);
    return Dismissible(
      key: ValueKey<String>(row['id'] as String? ?? 'meal-$index'),
      direction: DismissDirection.startToEnd,
      background: _dismissBackground(context),
      onDismissed: (DismissDirection direction) => onDeleteMeal(row),
      child: content,
    );
  }

  // Delete swipe background — revealed at the start edge in both directions.
  Widget _dismissBackground(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      alignment: AlignmentDirectional.centerStart,
      color: scheme.errorContainer,
      padding: EdgeInsetsDirectional.only(start: 16.w),
      child: Icon(
        Icons.delete,
        size: 24.r,
        color: scheme.onErrorContainer,
      ),
    );
  }

  // ≥48dp replay target at the row end (G-12 «سجّلها تاني»).
  Widget? _relogAction(BuildContext context, Map<String, dynamic> row) {
    if (onRelogMeal == null) return null;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: () => onRelogMeal!(row),
      tooltip: context.translate(LangKeys.mealRelogCta),
      icon: Icon(Icons.replay, size: 20.r, color: scheme.onSurfaceVariant),
      constraints: BoxConstraints(minWidth: 48.w, minHeight: 48.h),
      padding: EdgeInsets.zero,
    );
  }

  // Contract field `type` falls back to breakfast (log screen precedent).
  MealType _mealTypeFor(Map<String, dynamic> row) => switch (row['type']) {
        'lunch' => MealType.lunch,
        'dinner' => MealType.dinner,
        'snack' => MealType.snack,
        _ => MealType.breakfast,
      };

  // Missing sync rides ok (spec §1.5 sync{ok, pending, failed}).
  SyncStatus _syncFor(Map<String, dynamic> row) => switch (row['sync']) {
        'pending' => SyncStatus.pending,
        'failed' => SyncStatus.failed,
        _ => SyncStatus.ok,
      };
}
