import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

/// Full-width undo snackbar (deck §2.3); screen shows it via ScaffoldMessenger.
class UndoSnackbar {
  const UndoSnackbar._();

  // TODO(motion): entrance stays framework-driven (deck asks fade on reduced-motion).
  static SnackBar build(
    BuildContext context, {
    required String message,
    VoidCallback? onUndo,
  }) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return SnackBar(
      behavior: SnackBarBehavior.fixed,
      backgroundColor: scheme.inverseSurface,
      duration: const Duration(seconds: 5),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: TextApp(
              text: message,
              textAlign: TextAlign.start,
              theme: context.textStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeightHelper.regular,
                color: scheme.onInverseSurface,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              onUndo?.call();
            },
            style: TextButton.styleFrom(
              foregroundColor: scheme.inversePrimary,
              minimumSize: Size(48.w, 48.h),
              padding: EdgeInsets.symmetric(horizontal: 8.w),
            ),
            child: TextApp(
              text: context.translate(LangKeys.saveUndo),
              theme: context.textStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeightHelper.medium,
                color: scheme.inversePrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
