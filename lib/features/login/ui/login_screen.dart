import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/di/injection_container.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/routes/app_routes.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/features/login/logic/login_cubit.dart';
import 'package:nesba_ai/features/login/ui/widgets/login_actions.dart';
import 'package:nesba_ai/features/login/ui/widgets/login_fields.dart';

/// Login screen — mock flow only, no real auth yet.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
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
                      text: context.translate(LangKeys.loginTitle),
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

  void _onStateChanged(BuildContext context, LoginState state) {
    if (state.status == LoginStatus.success) {
      context.pushReplacementNamed(AppRoutes.home);
      return;
    }
    if (state.status == LoginStatus.error) {
      _showInvalidSnackBar(context);
    }
  }

  // Invalid-credentials toast — simple errorContainer snackbar, no undo.
  void _showInvalidSnackBar(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: scheme.errorContainer,
          duration: const Duration(seconds: 4),
          content: TextApp(
            text: context.translate(LangKeys.loginErrorInvalid),
            theme: context.textStyle.copyWith(
              fontSize: 14.sp,
              color: scheme.onErrorContainer,
            ),
          ),
        ),
      );
  }

  Widget _fields(BuildContext context, LoginState state) {
    final LoginCubit cubit = context.read<LoginCubit>();
    return LoginFields(
      emailController: _emailController,
      passwordController: _passwordController,
      emailError: state.emailError,
      passwordError: state.passwordError,
      onEmailChanged: cubit.emailChanged,
      onPasswordChanged: cubit.passwordChanged,
    );
  }

  Widget _actions(BuildContext context, LoginState state) {
    final LoginCubit cubit = context.read<LoginCubit>();
    return LoginActions(
      isLoading: state.status == LoginStatus.loading,
      onLogin: () => cubit.login(
        invalidEmailText: context.translate(LangKeys.validationEmail),
        shortPasswordText: context.translate(LangKeys.validationPasswordShort),
      ),
      // Signup link — pushes signup over login.
      onCreateAccount: () => context.pushName(AppRoutes.signUp),
    );
  }
}
