import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';

/// Name + email + password + confirm fields — errors arrive as ready-translated strings.
class SignUpFields extends StatelessWidget {
  const SignUpFields({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.nameError,
    required this.emailError,
    required this.passwordError,
    required this.confirmPasswordError,
    required this.onNameChanged,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.onConfirmPasswordChanged,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final String? nameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPasswordChanged;
  final ValueChanged<String> onConfirmPasswordChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: nameController,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          onChanged: onNameChanged,
          decoration: InputDecoration(
            labelText: context.translate(LangKeys.nameLabel),
            errorText: nameError,
          ),
        ),
        SizedBox(height: 16.h),
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
          labelText: context.translate(LangKeys.passwordLabel),
          errorText: passwordError,
          onChanged: onPasswordChanged,
        ),
        SizedBox(height: 16.h),
        _PasswordField(
          controller: confirmPasswordController,
          labelText: context.translate(LangKeys.confirmPasswordLabel),
          errorText: confirmPasswordError,
          onChanged: onConfirmPasswordChanged,
        ),
      ],
    );
  }
}

// Eye toggle is field-local UI state.
class _PasswordField extends StatefulWidget {
  const _PasswordField({
    required this.controller,
    required this.labelText,
    required this.errorText,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String labelText;
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
        labelText: widget.labelText,
        errorText: widget.errorText,
        suffixIcon: IconButton(
          onPressed: () => setState(() => _obscure = !_obscure),
          constraints: BoxConstraints(minWidth: 48.w, minHeight: 48.h),
          icon: Icon(
            _obscure
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          // TODO(a11y): show/hide password semantics keys missing from deck.
        ),
      ),
    );
  }
}
