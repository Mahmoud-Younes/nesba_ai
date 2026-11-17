import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/features/page_three/logic/page_three_cubit.dart';

/// PageThreeCubit demo: a switch toggles a boolean state,
/// and the content fades in / out accordingly.
class VisibilitySection extends StatelessWidget {
  const VisibilitySection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PageThreeCubit>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: context.color.containerLinear1,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.visibility_outlined,
                color: context.color.greenLight,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: TextApp(
                  text: context.translate(LangKeys.toggleContent),
                  theme: context.textStyle.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeightHelper.regular,
                  ),
                ),
              ),
              BlocBuilder<PageThreeCubit, PageThreeState>(
                builder: (context, state) {
                  return Switch.adaptive(
                    value: cubit.isContentVisible,
                    activeTrackColor: context.color.greenLight,
                    onChanged: (value) {
                      cubit.toggleContentVisibility();
                    },
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // The content that is shown / hidden by the cubit.
          BlocBuilder<PageThreeCubit, PageThreeState>(
            builder: (context, state) {
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: cubit.isContentVisible ? 1 : 0,
                child: Container(
                  height: 110.h,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        context.color.containerLinear2!,
                        context.color.greenDark!,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: TextApp(
                    text: context.translate(LangKeys.appName),
                    theme: context.textStyle.copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeightHelper.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
