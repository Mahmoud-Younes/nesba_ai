import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/app/app_cubit/app_cubit.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/helpers/spacing.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/app_type_scale.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/core/widgets/nes_app_bar.dart';
import 'package:nesba_ai/core/widgets/nes_page_header.dart';
import 'package:nesba_ai/core/widgets/nes_screen_body.dart';
import 'package:nesba_ai/core/widgets/nes_section_card.dart';
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
        child: NesScreenBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              NesPageHeader(title: context.translate(LangKeys.settings)),
              verticalSpace(AppSpacing.s16),
              NesSectionCard(child: _appearanceSection(context)),
              verticalSpace(AppSpacing.s16),
              const NesSectionCard(child: GoalCard()),
              verticalSpace(AppSpacing.s16),
              NesSectionCard(child: _aboutSection(context)),
            ],
          ),
        ),
      ),
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
                          text: context.translate(
                            LangKeys.settingsLanguageLabel,
                          ),
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
        // Group heading inside the card — the shape main uses for a form
        // group ("Eating Pattern"), not the heading-above-card shape.
        NesFieldLabel(text: context.translate(LangKeys.settingsAbout)),
        verticalSpace(AppSpacing.s8),
        TextApp(
          text: context.translate(LangKeys.settingsAboutBody),
          theme: context.textStyle.copyWith(
            fontSize: AppTypeScale.bodyMedium.sp,
            fontWeight: FontWeightHelper.regular,
            color: scheme.onSurfaceVariant,
          ),
        ),
        verticalSpace(AppSpacing.s8),
        TextApp(
          text: context.translate(LangKeys.disclaimerFull),
          theme: context.textStyle.copyWith(
            fontSize: AppTypeScale.bodySmall.sp,
            fontWeight: FontWeightHelper.regular,
            color: scheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
