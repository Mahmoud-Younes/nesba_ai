import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onPressed,
    required this.text,
    required this.width,
    required this.height,
    super.key,
    this.backgroundColor,
    this.textColor,
  });
  final VoidCallback onPressed;
  final String text;
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
          shape: const StadiumBorder(),
        ),
        onPressed: onPressed,
        child: TextApp(
          theme: context.textStyle.copyWith(
            color: textColor ?? Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeightHelper.medium,
            fontSize: 14.sp,
          ),
          text: text,
        ),
      ),
    );
  }
}
