import 'package:nesba_ai/core/firebase/goal_value.dart';

abstract interface class GoalRepo {
  Stream<GoalValue> watchGoal();
  Future<GoalValue> readGoal();
  Future<void> writeGoal(GoalValue goal);
}
