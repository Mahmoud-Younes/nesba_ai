import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/app/app_cubit/app_cubit.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/core/widgets/nes_app_bar.dart';
import 'package:nesba_ai/features/settings/ui/widgets/goal_card.dart';

/// «الإعدادات» — theme + language + daily goal + about (ticket 27);
/// opened from the app bar settings icon (shell wiring, ticket 21).
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      // Pushed from any gate bar — the back button is implied.
      appBar: NesAppBar(showBack: true),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.w),
          children: <Widget>[
            TextApp(
              text: context.translate(LangKeys.settings),
              theme: context.textStyle.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeightHelper.semiBold,
                color: scheme.onSurface,
              ),
            ),
            SizedBox(height: 16.h),
            _card(context, _appearanceSection(context)),
            SizedBox(height: 16.h),
            _card(context, const GoalCard()),
            SizedBox(height: 16.h),
            _card(context, _aboutSection(context)),
          ],
        ),
      ),
    );
  }

  // Section card: surfaceContainer tint, corner 12 (Bustan card token).
  Widget _card(BuildContext context, Widget child) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: child,
    );
  }

  // Theme + language rows; BlocBuilder keeps the switch value live.
  Widget _appearanceSection(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        final AppCubit cubit = context.read<AppCubit>();
        final ColorScheme scheme = Theme.of(context).colorScheme;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SwitchListTile(
              value: cubit.isDark,
              // No-arg call toggles and persists (the sharedMode param is
              // the restore-on-start path).
              onChanged: (_) => cubit.changeAppThemeMode(),
              activeThumbColor: scheme.primary,
              contentPadding: EdgeInsets.zero,
              title: TextApp(
                text: context.translate(LangKeys.darkMode),
                theme: context.textStyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeightHelper.medium,
                  color: scheme.onSurface,
                ),
              ),
            ),
            _languageRow(context, cubit, scheme),
          ],
        );
      },
    );
  }

  Widget _languageRow(
    BuildContext context,
    AppCubit cubit,
    ColorScheme scheme,
  ) {
    return MergeSemantics(
      child: Semantics(
        button: true,
        child: InkWell(
          onTap: () => cubit.currentLangCode == 'en'
              ? cubit.toArabic()
              : cubit.toEnglish(),
          borderRadius: BorderRadius.circular(8.r),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 48),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextApp(
                          text: context
                              .translate(LangKeys.settingsLanguageLabel),
                          theme: context.textStyle.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeightHelper.regular,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        TextApp(
                          text: context.translate(LangKeys.language),
                          theme: context.textStyle.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeightHelper.medium,
                            color: scheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Directionality.of(context) == TextDirection.ltr
                        ? Icons.chevron_right
                        : Icons.chevron_left,
                    size: 24.r,
                    color: scheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // «عن نِسْبَة» — body + full disclaimer, both quiet onSurfaceVariant.
  Widget _aboutSection(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextApp(
          text: context.translate(LangKeys.settingsAbout),
          theme: context.textStyle.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeightHelper.semiBold,
            color: scheme.onSurface,
          ),
        ),
        SizedBox(height: 8.h),
        TextApp(
          text: context.translate(LangKeys.settingsAboutBody),
          theme: context.textStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeightHelper.regular,
            color: scheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 8.h),
        TextApp(
          text: context.translate(LangKeys.disclaimerFull),
          theme: context.textStyle.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeightHelper.regular,
            color: scheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

