import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

/// Signup CTA (idle/loading) + the «لديك حساب؟» login row.
class SignUpActions extends StatelessWidget {
  const SignUpActions({
    required this.isLoading,
    required this.onSignUp,
    required this.onLogin,
    super.key,
  });

  final bool isLoading;
  final VoidCallback onSignUp;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        _signupButton(context, scheme),
        SizedBox(height: 16.h),
        _loginRow(context, scheme),
      ],
    );
  }

  Widget _signupButton(BuildContext context, ColorScheme scheme) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: FilledButton(
        onPressed: isLoading ? null : onSignUp,
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
      text: context.translate(LangKeys.signupCta),
      maxLines: 1,
      textOverflow: TextOverflow.ellipsis,
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
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
          theme: context.textStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeightHelper.medium,
            color: scheme.onPrimary,
          ),
        ),
      ],
    );
  }

  Widget _loginRow(BuildContext context, ColorScheme scheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextApp(
          text: context.translate(LangKeys.signupHaveAccount),
          theme: context.textStyle.copyWith(
            fontSize: 14.sp,
            color: scheme.onSurfaceVariant,
          ),
        ),
        TextButton(
          onPressed: onLogin,
          style: TextButton.styleFrom(minimumSize: Size(64, 48.h)),
          child: TextApp(
            text: context.translate(LangKeys.signupLoginLink),
            maxLines: 1,
            textOverflow: TextOverflow.ellipsis,
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
