import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/app/app_cubit/app_cubit.dart';
import 'package:nesba_ai/core/common/widgets/custom_button.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

/// Same pattern as asroo_store LanguageChange widget:
/// one button that switches between Arabic and English.
class LanguageChange extends StatelessWidget {
  const LanguageChange({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.color.containerLinear1,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.language,
            color: context.color.greenLight,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextApp(
              text: context.translate(LangKeys.langTest),
              theme: context.textStyle.copyWith(
                fontSize: 15.sp,
                fontWeight: FontWeightHelper.regular,
              ),
            ),
          ),
          CustomButton(
            text: context.translate(LangKeys.language),
            width: 100.w,
            height: 40.h,
            onPressed: () {
              cubit.currentLangCode == 'en'
                  ? cubit.toArabic()
                  : cubit.toEnglish();
            },
          ),
        ],
      ),
    );
  }
}
