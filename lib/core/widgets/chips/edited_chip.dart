import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

class EditedChip extends StatelessWidget {
  const EditedChip({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: TextApp(
        text: context.translate(LangKeys.editedChip),
        textAlign: TextAlign.start,
        theme: context.textStyle.copyWith(
          fontSize: 11.sp,
          fontWeight: FontWeightHelper.semiBold,
          color: scheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
