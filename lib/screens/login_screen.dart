import 'package:flutter/material.dart';

import '../widgets/auth_form_panel.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _passwordVisible = false;
  String? _notice;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(
      () => _notice = 'Authentication is not connected in this UI-only screen.',
    );
  }

  void _continueWithGoogle() {
    FocusScope.of(context).unfocus();
    setState(
      () => _notice = 'Google sign-in is not connected in this UI-only screen.',
    );
  }

  @override
  Widget build(BuildContext context) => _AuthScaffold(
    eyebrow: 'Welcome back',
    title: 'Sign in',
    description: 'Continue your food and wellbeing journey.',
    panel: AuthFormPanel(
      formKey: _formKey,
      submitLabel: 'Sign in',
      notice: _notice,
      onSubmit: _submit,
      onGoogleSignIn: _continueWithGoogle,
      children: [
        AuthTextField(
          controller: _email,
          label: 'Email',
          validator: emailValue,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        AuthTextField(
          controller: _password,
          label: 'Password',
          validator: (value) => requiredValue(value, 'Password'),
          obscureText: !_passwordVisible,
          onVisibilityToggle: () =>
              setState(() => _passwordVisible = !_passwordVisible),
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _submit(),
        ),
      ],
    ),
    footer: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(child: Text("Don't have an account?")),
        TextButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const RegisterScreen()),
          ),
          child: const Text('Create account'),
        ),
      ],
    ),
  );
}

class _AuthScaffold extends StatelessWidget {
  const _AuthScaffold({
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.panel,
    required this.footer,
  });

  final String eyebrow;
  final String title;
  final String description;
  final Widget panel;
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - 32,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        eyebrow.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 24),
                      panel,
                      const SizedBox(height: 12),
                      footer,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
