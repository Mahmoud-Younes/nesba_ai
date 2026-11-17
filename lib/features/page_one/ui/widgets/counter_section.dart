import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/custom_button.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/features/page_one/logic/page_one_cubit.dart';

/// PageOneCubit demo: the number is rebuilt from the cubit
/// every time a new [PageOneState.counterChanged] is emitted.
class CounterSection extends StatelessWidget {
  const CounterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PageOneCubit>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: context.color.containerLinear1,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          TextApp(
            text: context.translate(LangKeys.counter),
            theme: context.textStyle.copyWith(
              fontSize: 15.sp,
              fontWeight: FontWeightHelper.medium,
            ),
          ),
          SizedBox(height: 6.h),
          // A hint line under the title.
          TextApp(
            text: context.translate(LangKeys.cubitHint),
            theme: context.textStyle.copyWith(
              fontSize: 11.sp,
              color: context.color.textFormBorder,
            ),
          ),
          SizedBox(height: 10.h),
          // The counter value with a small fade animation
          // so the state change is visible.
          BlocBuilder<PageOneCubit, PageOneState>(
            builder: (context, state) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: TextApp(
                  key: ValueKey(cubit.counter),
                  text: '${cubit.counter}',
                  theme: context.textStyle.copyWith(
                    fontSize: 46.sp,
                    fontWeight: FontWeightHelper.bold,
                    color: context.color.greenLight,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: context.translate(LangKeys.decrement),
                width: 100.w,
                height: 44.h,
                onPressed: () {
                  cubit.decrement();
                },
              ),
              SizedBox(width: 10.w),
              CustomButton(
                text: context.translate(LangKeys.reset),
                width: 80.w,
                height: 44.h,
                backgroundColor: context.color.greenLight,
                onPressed: () {
                  cubit.reset();
                },
              ),
              SizedBox(width: 10.w),
              CustomButton(
                text: context.translate(LangKeys.increment),
                width: 100.w,
                height: 44.h,
                onPressed: () {
                  cubit.increment();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
