import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

/// Meal type of a logged meal — drives the 4 demo food icons (spec §1.5).
enum MealType { breakfast, lunch, dinner, snack }

/// Food icon per meal type — 24dp from Icons.* (brand §1.5 demo set).
IconData mealTypeIcon(MealType type) {
  return switch (type) {
    MealType.breakfast => Icons.free_breakfast_outlined,
    MealType.lunch => Icons.lunch_dining_outlined,
    MealType.dinner => Icons.dinner_dining_outlined,
    MealType.snack => Icons.cookie_outlined,
  };
}

/// Localized meal label key per type (deck meal_type_*).
String mealTypeLabelKey(MealType type) {
  return switch (type) {
    MealType.breakfast => LangKeys.mealTypeBreakfast,
    MealType.lunch => LangKeys.mealTypeLunch,
    MealType.dinner => LangKeys.mealTypeDinner,
    MealType.snack => LangKeys.mealTypeSnack,
  };
}

/// «فطار · 8:15 ص» — meal label + FSI-isolated time path (states §3.3).
String mealSubLine(BuildContext context, MealType type, String timeText) {
  return '${context.translate(mealTypeLabelKey(type))} · \u2068$timeText\u2069';
}

/// Ledger mini row: 64dp — food icon, name, meal·time line, tabular kcal,
/// outlineVariant divider with 12 spacing (spec §1.5 LedgerRow).
class LedgerRow extends StatelessWidget {
  const LedgerRow({
    required this.name,
    required this.mealType,
    required this.timeText,
    required this.kcalText,
    super.key,
  });

  final String name;
  final MealType mealType;
  final String timeText;

  /// Pre-formatted kcal value — western digits, rendered tabular.
  final String kcalText;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: 64.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                mealTypeIcon(mealType),
                size: 24.r,
                color: scheme.onSurfaceVariant,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextApp(
                      text: name,
                      theme: context.textStyle.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.semiBold,
                        color: scheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    TextApp(
                      text: mealSubLine(context, mealType, timeText),
                      theme: context.textStyle.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeightHelper.regular,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              TextApp(
                text: kcalText,
                theme: context.textStyle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeightHelper.regular,
                  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
                  color: scheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Divider(height: 1, thickness: 1, color: scheme.outlineVariant),
      ],
    );
  }
}
