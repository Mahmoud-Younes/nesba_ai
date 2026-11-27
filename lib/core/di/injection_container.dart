import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nesba_ai/core/app/app_cubit/app_cubit.dart';
import 'package:nesba_ai/core/firebase/auth_repo.dart';
import 'package:nesba_ai/core/firebase/auth_session.dart';
import 'package:nesba_ai/core/firebase/goal_repo.dart';
import 'package:nesba_ai/core/firebase/meals_repo.dart';
import 'package:nesba_ai/core/firebase/pending_repos.dart';
import 'package:nesba_ai/core/firebase/profile_repo.dart';
import 'package:nesba_ai/features/log/data/repos/log_repo.dart';
import 'package:nesba_ai/features/log/data/repos/mock_log_repo.dart';
import 'package:nesba_ai/features/log/logic/log_cubit.dart';
import 'package:nesba_ai/features/login/logic/login_cubit.dart';
import 'package:nesba_ai/features/review/data/repos/mock_review_repo.dart';
import 'package:nesba_ai/features/review/data/repos/review_repo.dart';
import 'package:nesba_ai/features/review/logic/review_cubit.dart';
import 'package:nesba_ai/features/sign_up/logic/sign_up_cubit.dart';
import 'package:nesba_ai/features/swaps/data/repos/mock_swap_repo.dart';
import 'package:nesba_ai/features/swaps/data/repos/swap_repo.dart';
import 'package:nesba_ai/features/swaps/logic/swap_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> setupInjector() async {
  await _initCore();
  await _initLog();
  await _initReview();
  await _initSwaps();
  await _initLogin();
  await _initSignUp();
}

Future<void> _initCore() async {
  final navigatorKey = GlobalKey<NavigatorState>();

  sl
    ..registerFactory(AppCubit.new)
    ..registerSingleton<GlobalKey<NavigatorState>>(navigatorKey)
    ..registerLazySingleton<AuthSession>(
      () => AuthSession(FirebaseAuth.instance),
    )
    ..registerLazySingleton<AuthRepo>(PendingAuthRepo.new)
    ..registerLazySingleton<MealsRepo>(PendingMealsRepo.new)
    ..registerLazySingleton<GoalRepo>(PendingGoalRepo.new)
    ..registerLazySingleton<ProfileRepository>(PendingProfileRepo.new);
}

Future<void> _initLog() async {
  sl
    ..registerLazySingleton<LogRepo>(MockLogRepo.new)
    // Singletons so the shell can refresh today's data on every gate
    // arrival while the IndexedStack keeps one instance alive.
    ..registerLazySingleton<LogCubit>(() => LogCubit(sl<LogRepo>()));
}

Future<void> _initReview() async {
  sl
    ..registerLazySingleton<ReviewRepo>(MockReviewRepo.new)
    ..registerLazySingleton<ReviewCubit>(() => ReviewCubit(sl<ReviewRepo>()));
}

Future<void> _initSwaps() async {
  sl
    ..registerLazySingleton<SwapRepo>(MockSwapRepo.new)
    ..registerFactory<SwapCubit>(() => SwapCubit(sl<SwapRepo>()));
}

Future<void> _initLogin() async {
  sl.registerFactory<LoginCubit>(LoginCubit.new);
}

Future<void> _initSignUp() async {
  sl.registerFactory<SignUpCubit>(SignUpCubit.new);
}
