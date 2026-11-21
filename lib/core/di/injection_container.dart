import 'package:flutter/material.dart';
import 'package:nesba_ai/core/app/app_cubit/app_cubit.dart';
import 'package:nesba_ai/features/log/data/repos/log_repo.dart';
import 'package:nesba_ai/features/log/data/repos/mock_log_repo.dart';
import 'package:nesba_ai/features/log/logic/log_cubit.dart';
import 'package:nesba_ai/features/login/logic/login_cubit.dart';
import 'package:nesba_ai/features/page_one/logic/page_one_cubit.dart';
import 'package:nesba_ai/features/page_three/logic/page_three_cubit.dart';
import 'package:nesba_ai/features/page_two/logic/page_two_cubit.dart';
import 'package:nesba_ai/features/review/data/repos/mock_review_repo.dart';
import 'package:nesba_ai/features/review/data/repos/review_repo.dart';
import 'package:nesba_ai/features/review/logic/review_cubit.dart';
import 'package:nesba_ai/features/swaps/data/repos/mock_swap_repo.dart';
import 'package:nesba_ai/features/swaps/data/repos/swap_repo.dart';
import 'package:nesba_ai/features/swaps/logic/swap_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> setupInjector() async {
  await _initCore();
  await _initTestPages();
  await _initLog();
  await _initReview();
  await _initSwaps();
  await _initLogin();
}

Future<void> _initCore() async {
  final navigatorKey = GlobalKey<NavigatorState>();

  sl
    ..registerFactory(AppCubit.new)
    ..registerSingleton<GlobalKey<NavigatorState>>(navigatorKey);
}

Future<void> _initTestPages() async {
  sl
    ..registerFactory(PageOneCubit.new)
    ..registerFactory(PageTwoCubit.new)
    ..registerFactory(PageThreeCubit.new);
}

Future<void> _initLog() async {
  sl
    ..registerLazySingleton<LogRepo>(MockLogRepo.new)
    ..registerFactory<LogCubit>(() => LogCubit(sl<LogRepo>()));
}

Future<void> _initReview() async {
  sl
    ..registerLazySingleton<ReviewRepo>(MockReviewRepo.new)
    ..registerFactory<ReviewCubit>(() => ReviewCubit(sl<ReviewRepo>()));
}

Future<void> _initSwaps() async {
  sl
    ..registerLazySingleton<SwapRepo>(MockSwapRepo.new)
    ..registerFactory<SwapCubit>(() => SwapCubit(sl<SwapRepo>()));
}

Future<void> _initLogin() async {
  sl.registerFactory<LoginCubit>(LoginCubit.new);
}
