import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/di/injection_container.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/routes/app_routes.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/features/sign_up/logic/sign_up_cubit.dart';
import 'package:nesba_ai/features/sign_up/ui/widgets/sign_up_actions.dart';
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
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextApp(
                      text: context.translate(LangKeys.signupTitle),
                      theme: context.textStyle.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeightHelper.semiBold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    _fields(context, state),
                    SizedBox(height: 24.h),
                    _actions(context, state),
                  ],
                ),
              ),
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
    if (state.status == SignUpStatus.error) {
      _showFirstFieldErrorSnackBar(context, state);
    }
  }

  // No generic signup error key — toast the first field error when present.
  void _showFirstFieldErrorSnackBar(BuildContext context, SignUpState state) {
    final String? errorText =
        state.nameError ??
        state.emailError ??
        state.passwordError ??
        state.confirmPasswordError;
    if (errorText == null) return;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: scheme.errorContainer,
          duration: const Duration(seconds: 4),
          content: TextApp(
            text: errorText,
            theme: context.textStyle.copyWith(
              fontSize: 14.sp,
              color: scheme.onErrorContainer,
            ),
          ),
        ),
      );
  }

  Widget _fields(BuildContext context, SignUpState state) {
    final SignUpCubit cubit = context.read<SignUpCubit>();
    return SignUpFields(
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
    );
  }

  Widget _actions(BuildContext context, SignUpState state) {
    final SignUpCubit cubit = context.read<SignUpCubit>();
    return SignUpActions(
      isLoading: state.status == SignUpStatus.loading,
      onSignUp: () => cubit.signup(
        nameEmptyText: context.translate(LangKeys.validationNameEmpty),
        invalidEmailText: context.translate(LangKeys.validationEmail),
        shortPasswordText: context.translate(LangKeys.validationPasswordShort),
        passwordMismatchText: context.translate(
          LangKeys.validationPasswordMatch,
        ),
      ),
      // Login link — the flow is linear, so login replaces signup.
      onLogin: () => context.pushReplacementNamed(AppRoutes.login),
    );
  }
}
