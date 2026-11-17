import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/app/app_cubit/app_cubit.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

/// Same pattern as asroo_store DarkModeChange widget:
/// reads `cubit.isDark` and calls `cubit.changeAppThemeMode()`.
class ThemeModeSwitch extends StatelessWidget {
  const ThemeModeSwitch({super.key});

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
            Icons.dark_mode_outlined,
            color: context.color.greenLight,
          ),
          SizedBox(width: 10.w),
          TextApp(
            text: context.translate(LangKeys.themeTest),
            theme: context.textStyle.copyWith(
              fontSize: 15.sp,
              fontWeight: FontWeightHelper.regular,
            ),
          ),
          const Spacer(),
          Switch.adaptive(
            value: cubit.isDark,
            activeTrackColor: context.color.greenLight,
            onChanged: (value) {
              cubit.changeAppThemeMode();
            },
          ),
        ],
      ),
    );
  }
}
