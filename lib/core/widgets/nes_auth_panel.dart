import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/helpers/spacing.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/app_type_scale.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/core/style/theme/app_radius.dart';
import 'package:nesba_ai/core/widgets/nes_page_header.dart';
import 'package:nesba_ai/core/widgets/nes_screen_body.dart';

/// Shared shape of the two auth screens: a centred eyebrow/title/subtitle
/// block, the form panel, then the switch-to-the-other-screen footer.
///
/// The column is vertically centred but still scrolls — at 200% text scale
/// or with the keyboard up the content grows past the viewport and must
/// stay reachable (states §5.2), so `minHeight` seeds the centring instead
/// of a fixed-height box.
class NesAuthScaffold extends StatelessWidget {
  const NesAuthScaffold({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.panel,
    required this.footer,
    super.key,
  });

  final String eyebrow;
  final String title;
  final String subtitle;
  final Widget panel;
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.all(AppSpacing.screenEdge.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      constraints.maxHeight - (AppSpacing.screenEdge.h * 2),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: NesScreenBody.maxContentWidth.w,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        NesPageHeader(
                          eyebrow: eyebrow,
                          title: title,
                          subtitle: subtitle,
                          centered: true,
                        ),
                        verticalSpace(AppSpacing.sectionDivider),
                        panel,
                        verticalSpace(AppSpacing.s12),
                        footer,
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// The form card: the screen's fields, the primary CTA, then the Google
/// alternative behind an "or" rule.
class NesAuthPanel extends StatelessWidget {
  const NesAuthPanel({
    required this.fields,
    required this.submitLabel,
    required this.isLoading,
    required this.onSubmit,
    required this.onGoogleSignIn,
    super.key,
  });

  final Widget fields;
  final String submitLabel;
  final bool isLoading;
  final VoidCallback onSubmit;
  final VoidCallback onGoogleSignIn;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.cardInner.w),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadius.medium.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          fields,
          verticalSpace(AppSpacing.s24),
          NesAuthSubmitButton(
            label: submitLabel,
            isLoading: isLoading,
            onPressed: onSubmit,
          ),
          verticalSpace(AppSpacing.s12),
          _orRule(context, scheme),
          verticalSpace(AppSpacing.s12),
          _googleButton(context, scheme),
        ],
      ),
    );
  }

  Widget _orRule(BuildContext context, ColorScheme scheme) {
    return Row(
      children: <Widget>[
        Expanded(child: Divider(color: scheme.outlineVariant)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.s12.w),
          child: TextApp(
            text: context.translate(LangKeys.authOr),
            theme: context.textStyle.copyWith(
              fontSize: AppTypeScale.bodySmall.sp,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(child: Divider(color: scheme.outlineVariant)),
      ],
    );
  }

  Widget _googleButton(BuildContext context, ColorScheme scheme) {
    // Outlined, not filled — one primary action per card, and the email
    // CTA above it owns that weight.
    return OutlinedButton(
      key: const ValueKey<String>('google-sign-in-button'),
      onPressed: isLoading ? null : onGoogleSignIn,
      style: OutlinedButton.styleFrom(
        minimumSize: Size.fromHeight(AppSpacing.s48.h),
        foregroundColor: scheme.onSurface,
        side: BorderSide(color: scheme.outline),
      ),
      child: TextApp(
        text: context.translate(LangKeys.authGoogleCta),
        theme: context.textStyle.copyWith(
          fontSize: AppTypeScale.labelLarge.sp,
          fontWeight: FontWeightHelper.semiBold,
          color: scheme.onSurface,
        ),
      ),
    );
  }
}

/// Primary auth CTA. Loading keeps the filled look and swaps the label for
/// a spinner plus the waiting copy, so the button never goes grey-dead
/// while a request is in flight.
class NesAuthSubmitButton extends StatelessWidget {
  const NesAuthSubmitButton({
    required this.label,
    required this.isLoading,
    required this.onPressed,
    super.key,
  });

  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    // Full width; height stays intrinsic above the theme's 48dp floor so
    // the label never clips at 200% text scale (states §5.2).
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: isLoading
            ? FilledButton.styleFrom(
                disabledBackgroundColor: scheme.primary,
                disabledForegroundColor: scheme.onPrimary,
              )
            : null,
        child: isLoading
            ? _loadingChild(context, scheme)
            : _label(context, scheme, label),
      ),
    );
  }

  Widget _label(BuildContext context, ColorScheme scheme, String text) {
    return TextApp(
      text: text,
      theme: context.textStyle.copyWith(
        fontSize: AppTypeScale.labelLarge.sp,
        fontWeight: FontWeightHelper.semiBold,
        color: scheme.onPrimary,
      ),
    );
  }

  Widget _loadingChild(BuildContext context, ColorScheme scheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 18.r,
          height: 18.r,
          child: CircularProgressIndicator(
            strokeWidth: 2.5.r,
            color: scheme.onPrimary,
          ),
        ),
        horizontalSpace(AppSpacing.s12),
        Flexible(
          child: _label(
            context,
            scheme,
            context.translate(LangKeys.authLoading),
          ),
        ),
      ],
    );
  }
}

/// The "no account yet? / already have one?" row under the panel.
class NesAuthFooterLink extends StatelessWidget {
  const NesAuthFooterLink({
    required this.prompt,
    required this.actionLabel,
    required this.onPressed,
    super.key,
  });

  final String prompt;
  final String actionLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    // Wrap, not Row: at 200% scale the prompt and the link stack instead of
    // overflowing the line.
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        TextApp(
          text: prompt,
          theme: context.textStyle.copyWith(
            fontSize: AppTypeScale.bodyMedium.sp,
            color: scheme.onSurfaceVariant,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            minimumSize: Size(64.w, AppSpacing.s48.h),
          ),
          child: TextApp(
            text: actionLabel,
            theme: context.textStyle.copyWith(
              fontSize: AppTypeScale.bodyMedium.sp,
              fontWeight: FontWeightHelper.semiBold,
              color: scheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
