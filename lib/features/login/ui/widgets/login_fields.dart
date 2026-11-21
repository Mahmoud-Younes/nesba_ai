import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';

/// Email + password fields — errors arrive as ready-translated strings.
class LoginFields extends StatelessWidget {
  const LoginFields({
    required this.emailController,
    required this.passwordController,
    required this.emailError,
    required this.passwordError,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String? emailError;
  final String? passwordError;
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPasswordChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: onEmailChanged,
          decoration: InputDecoration(
            labelText: context.translate(LangKeys.emailLabel),
            errorText: emailError,
          ),
        ),
        SizedBox(height: 16.h),
        _PasswordField(
          controller: passwordController,
          errorText: passwordError,
          onChanged: onPasswordChanged,
        ),
      ],
    );
  }
}

// Eye toggle is field-local UI state.
class _PasswordField extends StatefulWidget {
  const _PasswordField({
    required this.controller,
    required this.errorText,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String> onChanged;

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscure,
      keyboardType: TextInputType.visiblePassword,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: context.translate(LangKeys.passwordLabel),
        errorText: widget.errorText,
        suffixIcon: IconButton(
          onPressed: () => setState(() => _obscure = !_obscure),
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          icon: Icon(
            _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          ),
          // TODO(a11y): show/hide password semantics keys missing from deck.
        ),
      ),
    );
  }
}
