import 'package:get_it/get_it.dart';
import 'package:nesba_ai/core/di/injection_container.dart';
import 'package:nesba_ai/core/firebase/auth_repo.dart';
import 'package:nesba_ai/core/firebase/goal_repo.dart';
import 'package:nesba_ai/core/firebase/meals_repo.dart';

import 'fake_repos.dart';

/// Registers in-memory fakes for the shared contracts. Call after
/// [setupInjector] in tests that need the new Firebase-facing interfaces.
void setupTestFakes() {
  final GetIt sl = GetIt.instance;
  if (!sl.isRegistered<AuthRepo>()) {
    sl.registerLazySingleton<AuthRepo>(FakeAuthRepo.new);
  }
  if (!sl.isRegistered<MealsRepo>()) {
    sl.registerLazySingleton<MealsRepo>(FakeMealsRepo.new);
  }
  if (!sl.isRegistered<GoalRepo>()) {
    sl.registerLazySingleton<GoalRepo>(FakeGoalRepo.new);
  }
}
