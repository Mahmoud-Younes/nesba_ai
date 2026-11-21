import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

/// Surface app bar with the localized wordmark and a 48dp settings action.
class NesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NesAppBar({
    this.title,
    this.onSettingsTap,
    this.showBack = false,
    super.key,
  });

  // Dynamic screen title (review follows the day/week switch); falls back
  // to the wordmark.
  final String? title;
  final VoidCallback? onSettingsTap;

  /// Implies the platform back button on pushed routes (settings).
  final bool showBack;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return AppBar(
      automaticallyImplyLeading: showBack,
      backgroundColor: scheme.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: TextApp(
        text: title ?? context.translate(LangKeys.appName),
        theme: context.textStyle.copyWith(
          fontSize: title == null ? 22.sp : 24.sp,
          fontWeight: FontWeightHelper.semiBold,
          color: scheme.onSurface,
        ),
      ),
      // No silent dead control: the gear renders only when it does something
      // (the settings screen itself passes no handler).
      actions: onSettingsTap == null
          ? null
          : <Widget>[
              Semantics(
                label: context.translate(LangKeys.settings),
                button: true,
                child: IconButton(
                  onPressed: onSettingsTap,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: 48.w, minHeight: 48.h),
                  icon: Icon(
                    Icons.settings_outlined,
                    size: 24.r,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
    );
  }
}
