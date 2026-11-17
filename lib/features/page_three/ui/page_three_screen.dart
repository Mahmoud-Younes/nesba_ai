import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/animations/animate_do.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/di/injection_container.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/features/page_three/logic/page_three_cubit.dart';
import 'package:nesba_ai/features/page_three/ui/widgets/back_home_button.dart';
import 'package:nesba_ai/features/page_three/ui/widgets/visibility_section.dart';

/// Test page #3: PageThreeCubit demo (boolean state)
/// + back navigation to page one (clears the whole stack).
class PageThreeScreen extends StatelessWidget {
  const PageThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PageThreeCubit>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: context.color.textColor,
          centerTitle: true,
          title: TextApp(
            text: context.translate(LangKeys.pageThree),
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
                // Boolean state demo (show / hide).
                CustomFadeInUp(
                  duration: 400,
                  child: const VisibilitySection(),
                ),
                SizedBox(height: 24.h),
                // Back to page one (removes all routes).
                CustomFadeInUp(
                  duration: 500,
                  child: const BackHomeButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
