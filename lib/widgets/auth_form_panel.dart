import 'package:flutter/material.dart';

class AuthFormPanel extends StatelessWidget {
  const AuthFormPanel({
    required this.formKey,
    required this.children,
    required this.onSubmit,
    required this.onGoogleSignIn,
    required this.submitLabel,
    this.notice,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final List<Widget> children;
  final VoidCallback onSubmit;
  final VoidCallback onGoogleSignIn;
  final String submitLabel;
  final String? notice;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...children,
            const SizedBox(height: 20),
            FilledButton(onPressed: onSubmit, child: Text(submitLabel)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: Divider(color: colors.outlineVariant)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'or',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: colors.outlineVariant)),
              ],
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              key: const ValueKey('google-sign-in-button'),
              onPressed: onGoogleSignIn,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                foregroundColor: colors.onSurface,
                side: BorderSide(color: colors.outline),
                shape: const StadiumBorder(),
              ),
              child: const Text('Continue with Google'),
            ),
            if (notice case final message?) ...[
              const SizedBox(height: 12),
              Semantics(
                liveRegion: true,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: colors.outlineVariant),
                  ),
                  child: Text(
                    message,
                    style: TextStyle(color: colors.onSurface),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    required this.controller,
    required this.label,
    required this.validator,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.onVisibilityToggle,
    this.onFieldSubmitted,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final VoidCallback? onVisibilityToggle;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    obscureText: obscureText,
    autocorrect: false,
    enableSuggestions: !obscureText,
    validator: validator,
    onFieldSubmitted: onFieldSubmitted,
    decoration: InputDecoration(
      labelText: label,
      suffixIcon: onVisibilityToggle == null
          ? null
          : IconButton(
              tooltip: obscureText ? 'Show password' : 'Hide password',
              onPressed: onVisibilityToggle,
              icon: Icon(
                obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
    ),
  );
}

String? requiredValue(String? value, String label) =>
    value == null || value.trim().isEmpty ? '$label is required' : null;

String? emailValue(String? value) {
  final required = requiredValue(value, 'Email');
  if (required != null) return required;
  return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value!.trim())
      ? null
      : 'Enter a valid email address';
}
