import 'package:nesba_ai/core/firebase/goal_value.dart';

/// The three states every goal reader must distinguish.
enum GoalState { unset, calculated, manual }

GoalState goalStateOf(GoalValue goal) {
  if (goal.isUnset) return GoalState.unset;
  return goal.source == GoalSource.manual
      ? GoalState.manual
      : GoalState.calculated;
}
