import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/custom_button.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/routes/app_routes.dart';

/// Clears the navigation stack and shows page one again.
class BackHomeButton extends StatelessWidget {
  const BackHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: context.translate(LangKeys.backHome),
      width: double.infinity,
      height: 50.h,
      backgroundColor: context.color.greenLight,
      onPressed: () {
        context.pushNamedAndRemoveUntil(AppRoutes.testHome);
      },
    );
  }
}
