abstract interface class GoalRepo {
  Stream<int> watchGoal();
  Future<int> readGoal();
  Future<void> writeGoal(int kcal);
}
