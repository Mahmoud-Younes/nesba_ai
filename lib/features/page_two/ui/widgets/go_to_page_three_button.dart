import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/custom_button.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/routes/app_routes.dart';

/// Pushes page three through [BaseRoute] (scale transition animation).
class GoToPageThreeButton extends StatelessWidget {
  const GoToPageThreeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: context.translate(LangKeys.next),
      width: double.infinity,
      height: 50.h,
      onPressed: () {
        context.pushName(AppRoutes.pageThree);
      },
    );
  }
}
