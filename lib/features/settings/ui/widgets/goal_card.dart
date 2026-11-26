import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/service/shared_pref/pref_keys.dart';
import 'package:nesba_ai/core/service/shared_pref/shared_pref.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

/// Daily goal card. Extracted from the settings screen so the authentication
/// track and the goal track can work on separate files.
class GoalCard extends StatefulWidget {
  const GoalCard({super.key});

  @override
  State<GoalCard> createState() => GoalCardState();
}

class GoalCardState extends State<GoalCard> {
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
            labelText: context.translate(LangKeys.settingsDailyGoal),
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: _isValidGoal ? _save : null,
            child: TextApp(
              text: context.translate(LangKeys.done),
              theme: context.textStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeightHelper.medium,
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
