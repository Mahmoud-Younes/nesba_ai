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
import 'package:nesba_ai/features/login/logic/login_cubit.dart';
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
          return NesAuthScaffold(
            eyebrow: context.translate(LangKeys.loginEyebrow),
            title: context.translate(LangKeys.loginTitle),
            subtitle: context.translate(LangKeys.loginSubtitle),
            panel: _panel(context, state),
            footer: NesAuthFooterLink(
              prompt: context.translate(LangKeys.loginNoAccount),
              actionLabel: context.translate(LangKeys.loginCreateAccount),
              // Signup link — pushes signup over login.
              onPressed: () => context.pushName(AppRoutes.signUp),
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
              fontSize: AppTypeScale.bodyMedium.sp,
              color: scheme.onErrorContainer,
            ),
          ),
        ),
      );
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

  Widget _panel(BuildContext context, LoginState state) {
    final LoginCubit cubit = context.read<LoginCubit>();
    return NesAuthPanel(
      submitLabel: context.translate(LangKeys.loginCta),
      isLoading: state.status == LoginStatus.loading,
      onSubmit: () => cubit.login(
        invalidEmailText: context.translate(LangKeys.validationEmail),
        shortPasswordText: context.translate(LangKeys.validationPasswordShort),
      ),
      onGoogleSignIn: () => _showGooglePendingSnackBar(context),
      fields: LoginFields(
        emailController: _emailController,
        passwordController: _passwordController,
        emailError: state.emailError,
        passwordError: state.passwordError,
        onEmailChanged: cubit.emailChanged,
        onPasswordChanged: cubit.passwordChanged,
      ),
    );
  }
}
