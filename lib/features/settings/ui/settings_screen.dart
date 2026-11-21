import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/app/app_cubit/app_cubit.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/app_localizations.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/service/shared_pref/pref_keys.dart';
import 'package:nesba_ai/core/service/shared_pref/shared_pref.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/core/widgets/nes_app_bar.dart';

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
            _card(context, const _GoalCard()),
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

  // TODO(language-label): deck §2.9 wants a «اللغة» row label — no such key
  // in lang/*.json yet; the `language` key itself carries the other
  // language's native name, so the row text doubles as the switch-to value.
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
            constraints: BoxConstraints(minHeight: 48.h),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextApp(
                      text: context.translate(LangKeys.language),
                      theme: context.textStyle.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeightHelper.medium,
                        color: scheme.onSurface,
                      ),
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

/// Daily goal card — numeric kcal goal persisted to SharedPref.
/// TODO(settings-goal): LogCubit reads this key later (its goal is a mock
/// 2000 for now) via int.tryParse(SharedPref().getString(
/// PrefKeys.dailyGoalKcal) ?? '').
class _GoalCard extends StatefulWidget {
  const _GoalCard();

  @override
  State<_GoalCard> createState() => _GoalCardState();
}

class _GoalCardState extends State<_GoalCard> {
  late final TextEditingController _controller;

  int? _goal;

  @override
  void initState() {
    super.initState();
    _goal = int.tryParse(SharedPref().getString(PrefKeys.dailyGoalKcal) ?? '');
    _controller = TextEditingController(text: _goal == null ? '' : '$_goal');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isValidGoal => _goal != null && _goal! > 0;

  void _onChanged(String text) => setState(() => _goal = int.tryParse(text));

  Future<void> _save() async {
    await SharedPref().setString(PrefKeys.dailyGoalKcal, '${_goal!}');
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(_savedSnackbar(context));
  }

  // Confirmation snackbar — same quiet styling as UndoSnackbar, no action.
  SnackBar _savedSnackbar(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return SnackBar(
      behavior: SnackBarBehavior.fixed,
      backgroundColor: scheme.inverseSurface,
      content: TextApp(
        text: context.translate(LangKeys.settingsGoalSaved),
        theme: context.textStyle.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeightHelper.regular,
          color: scheme.onInverseSurface,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextApp(
          text: context.translate(LangKeys.settingsDailyGoal),
          theme: context.textStyle.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeightHelper.semiBold,
            color: scheme.onSurface,
          ),
        ),
        SizedBox(height: 12.h),
        TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: _onChanged,
          decoration: InputDecoration(
            // TODO(copy): «سعرة» suffix key missing from the deck — the
            // label already carries the unit; no suffix until one lands.
            labelText: context.translate(LangKeys.settingsDailyGoal),
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            // TODO(copy): plain «تم/Save» key missing from the deck —
            // locale literal per the LogScreen «تم/Done» precedent.
            onPressed: _isValidGoal ? _save : null,
            child: TextApp(
              text: AppLocalizations.of(context)!.isEnLocale ? 'Done' : 'تم',
              theme: context.textStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeightHelper.medium,
                // Disabled label rides the deck's onSurface 38% rule.
                color: _isValidGoal
                    ? scheme.onPrimary
                    : scheme.onSurface.withValues(alpha: 0.38),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
