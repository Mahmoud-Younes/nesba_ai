import 'package:flutter/material.dart';
import 'package:nesba_ai/core/app/app_cubit/app_cubit.dart';
import 'package:nesba_ai/features/log/data/repos/log_repo.dart';
import 'package:nesba_ai/features/log/data/repos/mock_log_repo.dart';
import 'package:nesba_ai/features/log/logic/log_cubit.dart';
import 'package:nesba_ai/features/page_one/logic/page_one_cubit.dart';
import 'package:nesba_ai/features/page_three/logic/page_three_cubit.dart';
import 'package:nesba_ai/features/page_two/logic/page_two_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> setupInjector() async {
  await _initCore();
  await _initTestPages();
  await _initLog();
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
