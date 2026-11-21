import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

class FitChip extends StatelessWidget {
  const FitChip({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.check, size: 14, color: scheme.onSecondaryContainer),
          SizedBox(width: 4.w),
          TextApp(
            text: context.translate(LangKeys.fitChip),
            textAlign: TextAlign.start,
            theme: context.textStyle.copyWith(
              fontSize: 11.sp,
              fontWeight: FontWeightHelper.semiBold,
              color: scheme.onSecondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
