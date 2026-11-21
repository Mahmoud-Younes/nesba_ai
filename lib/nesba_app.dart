import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/app/app_cubit/app_cubit.dart';
import 'package:nesba_ai/core/di/injection_container.dart';
import 'package:nesba_ai/core/language/app_localizations_setup.dart';
import 'package:nesba_ai/core/routes/app_routes.dart';
import 'package:nesba_ai/core/service/shared_pref/pref_keys.dart';
import 'package:nesba_ai/core/service/shared_pref/shared_pref.dart';
import 'package:nesba_ai/core/style/theme/app_theme.dart';

/// The root widget of the app.
///
/// Here we:
/// 1. Provide [AppCubit] (theme + language).
/// 2. Rebuild [MaterialApp] when the theme or the language changes.
/// 3. Use [AppRoutes.onGenerateRoute] with the animated [BaseRoute].
class NesbaApp extends StatelessWidget {
  const NesbaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AppCubit>()
            ..changeAppThemeMode(
              // First run: null => default to dark mode.
              sharedMode: SharedPref().getBoolean(PrefKeys.themeMode) ?? true,
            )
            ..getSavedLanguage(),
        ),
      ],
      child: ScreenUtilInit(
        // Design frame per design/screen-specs.md ("فريم 390×844dp").
        designSize: const Size(390, 844),
        minTextAdapt: true,
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            final cubit = context.read<AppCubit>();
            return MaterialApp(
              title: 'Nesba',
              debugShowCheckedModeBanner: false,
              theme: cubit.isDark ? themeDark() : themeLight(),
              locale: Locale(cubit.currentLangCode),
              supportedLocales: AppLocalizationsSetup.supportedLocales,
              localizationsDelegates:
                  AppLocalizationsSetup.localizationsDelegates,
              localeResolutionCallback:
                  AppLocalizationsSetup.localeResolutionCallback,
              builder: (context, widget) {
                // Dismiss the keyboard on any tap outside a text field.
                return GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: widget!,
                );
              },
              navigatorKey: sl<GlobalKey<NavigatorState>>(),
              onGenerateRoute: AppRoutes.onGenerateRoute,
              initialRoute: AppRoutes.splash,
            );
          },
        ),
      ),
    );
  }
}
