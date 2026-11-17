import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/features/page_two/logic/page_two_cubit.dart';

/// Rebuilt by [PageTwoState.colorChanged]: the container
/// animates to the newly selected color.
class ColorPreview extends StatelessWidget {
  const ColorPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PageTwoCubit>();
    return Column(
      children: [
        TextApp(
          text: context.translate(LangKeys.chooseColor),
          theme: context.textStyle.copyWith(
            fontSize: 15.sp,
            fontWeight: FontWeightHelper.medium,
          ),
        ),
        SizedBox(height: 12.h),
        BlocBuilder<PageTwoCubit, PageTwoState>(
          builder: (context, state) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              height: 140.h,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: cubit.selectedColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: TextApp(
                text: '${cubit.selectedColorIndex + 1}',
                theme: context.textStyle.copyWith(
                  fontSize: 40.sp,
                  fontWeight: FontWeightHelper.bold,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
