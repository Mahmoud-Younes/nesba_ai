import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/animations/animate_do.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/di/injection_container.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/features/page_two/logic/page_two_cubit.dart';
import 'package:nesba_ai/features/page_two/ui/widgets/color_palette_row.dart';
import 'package:nesba_ai/features/page_two/ui/widgets/color_preview.dart';
import 'package:nesba_ai/features/page_two/ui/widgets/go_to_page_three_button.dart';

/// Test page #2: PageTwoCubit demo (selecting a color)
/// + navigation to page three.
class PageTwoScreen extends StatelessWidget {
  const PageTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PageTwoCubit>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: context.color.textColor,
          centerTitle: true,
          title: TextApp(
            text: context.translate(LangKeys.pageTwo),
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
                // The big preview painted with the selected color.
                CustomFadeInUp(
                  duration: 400,
                  child: const ColorPreview(),
                ),
                SizedBox(height: 16.h),
                // The palette circles (one tap = one new state).
                CustomFadeInUp(
                  duration: 500,
                  child: const ColorPaletteRow(),
                ),
                SizedBox(height: 24.h),
                // Navigation to page three.
                CustomFadeInUp(
                  duration: 600,
                  child: const GoToPageThreeButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
