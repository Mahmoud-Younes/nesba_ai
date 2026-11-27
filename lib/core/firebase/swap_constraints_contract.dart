import 'package:nesba_ai/core/firebase/goal_value.dart';
import 'package:nesba_ai/core/firebase/meal_alternatives.dart';
import 'package:nesba_ai/core/firebase/restriction_category.dart';

/// Final signature of the pure decision function. Person 2 implements it;
/// Person 4 calls it at display time without waiting for that branch.
typedef SwapConstraints =
    List<RawAlternative> Function({
      required List<RawAlternative> candidates,
      required Set<RestrictionCategory> selectedCategories,
      required GoalValue goal,
      required int loggedMealKcal,
      required int remainingCalories,
    });
