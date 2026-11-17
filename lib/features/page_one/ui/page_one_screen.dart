import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/animations/animate_do.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/di/injection_container.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/features/page_one/logic/page_one_cubit.dart';
import 'package:nesba_ai/features/page_one/ui/widgets/counter_section.dart';
import 'package:nesba_ai/features/page_one/ui/widgets/go_to_page_two_button.dart';
import 'package:nesba_ai/features/page_one/ui/widgets/language_change.dart';
import 'package:nesba_ai/features/page_one/ui/widgets/theme_mode_switch.dart';

/// Test page #1:
/// - AppCubit demo (theme switch + language change).
/// - PageOneCubit demo (counter).
/// - Navigation demo (push to page two with BaseRoute animation).
class PageOneScreen extends StatelessWidget {
  const PageOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PageOneCubit>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: context.color.textColor,
          centerTitle: true,
          title: TextApp(
            text: context.translate(LangKeys.pageOne),
            theme: context.textStyle.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeightHelper.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              children: [
                // AppCubit: theme mode.
                CustomFadeInUp(
                  duration: 400,
                  child: const ThemeModeSwitch(),
                ),
                SizedBox(height: 16.h),
                // AppCubit: language.
                CustomFadeInUp(
                  duration: 500,
                  child: const LanguageChange(),
                ),
                SizedBox(height: 16.h),
                // PageOneCubit: counter.
                CustomFadeInUp(
                  duration: 600,
                  child: const CounterSection(),
                ),
                SizedBox(height: 24.h),
                // Navigation to page two.
                CustomFadeInUp(
                  duration: 700,
                  child: const GoToPageTwoButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
