import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

/// Login CTA (idle/loading) + the «ليس لديك حساب؟» signup row.
class LoginActions extends StatelessWidget {
  const LoginActions({
    required this.isLoading,
    required this.onLogin,
    required this.onCreateAccount,
    super.key,
  });

  final bool isLoading;
  final VoidCallback onLogin;
  final VoidCallback onCreateAccount;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        _loginButton(context, scheme),
        SizedBox(height: 16.h),
        _signupRow(context, scheme),
      ],
    );
  }

  Widget _loginButton(BuildContext context, ColorScheme scheme) {
    // Full width; height is intrinsic with the theme's 48dp floor — no
    // tight box that clips at 200% text scale (states §5.2).
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: isLoading ? null : onLogin,
        // Loading keeps the primary look with an in-button indicator.
        style: isLoading
            ? FilledButton.styleFrom(
                disabledBackgroundColor: scheme.primary,
                disabledForegroundColor: scheme.onPrimary,
              )
            : null,
        child: isLoading
            ? _loadingChild(context, scheme)
            : _ctaChild(context, scheme),
      ),
    );
  }

  Widget _ctaChild(BuildContext context, ColorScheme scheme) {
    return TextApp(
      text: context.translate(LangKeys.loginCta),
      theme: context.textStyle.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.medium,
        color: scheme.onPrimary,
      ),
    );
  }

  Widget _loadingChild(BuildContext context, ColorScheme scheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 18.r,
          height: 18.r,
          child: CircularProgressIndicator(
            strokeWidth: 2.5.r,
            color: scheme.onPrimary,
          ),
        ),
        SizedBox(width: 12.w),
        TextApp(
          text: context.translate(LangKeys.authLoading),
          theme: context.textStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeightHelper.medium,
            color: scheme.onPrimary,
          ),
        ),
      ],
    );
  }

  Widget _signupRow(BuildContext context, ColorScheme scheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextApp(
          text: context.translate(LangKeys.loginNoAccount),
          theme: context.textStyle.copyWith(
            fontSize: 14.sp,
            color: scheme.onSurfaceVariant,
          ),
        ),
        TextButton(
          onPressed: onCreateAccount,
          style: TextButton.styleFrom(minimumSize: const Size(64, 48)),
          child: TextApp(
            text: context.translate(LangKeys.loginCreateAccount),
            theme: context.textStyle.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeightHelper.medium,
              color: scheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
