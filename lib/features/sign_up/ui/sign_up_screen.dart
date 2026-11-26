import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/di/injection_container.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/routes/app_routes.dart';
import 'package:nesba_ai/core/style/fonts/app_type_scale.dart';
import 'package:nesba_ai/core/widgets/nes_auth_panel.dart';
import 'package:nesba_ai/features/sign_up/logic/sign_up_cubit.dart';
import 'package:nesba_ai/features/sign_up/ui/widgets/sign_up_fields.dart';

/// Signup screen — mock flow only, no real auth yet.
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignUpCubit>(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) => _onStateChanged(context, state),
        builder: (context, state) {
          return NesAuthScaffold(
            eyebrow: context.translate(LangKeys.signupEyebrow),
            title: context.translate(LangKeys.signupTitle),
            subtitle: context.translate(LangKeys.signupSubtitle),
            panel: _panel(context, state),
            footer: NesAuthFooterLink(
              prompt: context.translate(LangKeys.signupHaveAccount),
              actionLabel: context.translate(LangKeys.signupLoginLink),
              // Back to the login already on the stack — no duplicate route.
              onPressed: () => Navigator.of(context).pop(),
            ),
          );
        },
      ),
    );
  }

  void _onStateChanged(BuildContext context, SignUpState state) {
    if (state.status == SignUpStatus.success) {
      context.pushReplacementNamed(AppRoutes.home);
      return;
    }
  }

  // The Google button is drawn but its provider lands with the auth track;
  // saying so beats a control that silently does nothing when tapped.
  void _showGooglePendingSnackBar(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content: TextApp(
            text: context.translate(LangKeys.authGooglePending),
            theme: context.textStyle.copyWith(
              fontSize: AppTypeScale.bodyMedium.sp,
              color: scheme.onInverseSurface,
            ),
          ),
        ),
      );
  }

  Widget _panel(BuildContext context, SignUpState state) {
    final SignUpCubit cubit = context.read<SignUpCubit>();
    return NesAuthPanel(
      submitLabel: context.translate(LangKeys.signupCta),
      isLoading: state.status == SignUpStatus.loading,
      onSubmit: () => cubit.signup(
        nameEmptyText: context.translate(LangKeys.validationNameEmpty),
        invalidEmailText: context.translate(LangKeys.validationEmail),
        shortPasswordText: context.translate(LangKeys.validationPasswordShort),
        passwordMismatchText: context.translate(
          LangKeys.validationPasswordMatch,
        ),
      ),
      onGoogleSignIn: () => _showGooglePendingSnackBar(context),
      fields: SignUpFields(
        nameController: _nameController,
        emailController: _emailController,
        passwordController: _passwordController,
        confirmPasswordController: _confirmPasswordController,
        nameError: state.nameError,
        emailError: state.emailError,
        passwordError: state.passwordError,
        confirmPasswordError: state.confirmPasswordError,
        onNameChanged: cubit.nameChanged,
        onEmailChanged: cubit.emailChanged,
        onPasswordChanged: cubit.passwordChanged,
        onConfirmPasswordChanged: cubit.confirmPasswordChanged,
      ),
    );
  }
}
