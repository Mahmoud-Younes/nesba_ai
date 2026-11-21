import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/helpers/spacing.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/core/style/theme/app_radius.dart';
import 'package:nesba_ai/core/widgets/calorie_ring.dart';
import 'package:nesba_ai/core/widgets/chips/estimate_chip.dart';
import 'package:nesba_ai/core/widgets/chips/verdict_chip.dart';
import 'package:nesba_ai/core/widgets/feedback/error_card.dart';
import 'package:nesba_ai/core/widgets/feedback/stale_guard_notice.dart';
import 'package:nesba_ai/core/widgets/rows/item_row.dart';
import 'package:nesba_ai/core/widgets/rows/macro_row.dart';
import 'package:nesba_ai/features/log/data/models/analysis_result.dart';
import 'package:nesba_ai/features/log/data/models/meal_item.dart';

/// S03 result card (spec §2.3): echo + kcal + verdict + macros + details
/// toggle collapsed; stale/timeout states on top, disclaimer as footer.
class ResultCard extends StatelessWidget {
  const ResultCard({
    required this.result,
    required this.onToggleExpand,
    required this.onSaveMeal,
    required this.onEditDescription,
    required this.onItemTap,
    required this.onAddItem,
    required this.onTeaserTap,
    this.isExpanded = false,
    this.isStale = false,
    this.isTimeout = false,
    this.isSaving = false,
    this.showDisclaimer = false,
    this.onReanalyze,
    this.onKeep,
    this.kcalUnitText,
    this.macroUnitText,
    super.key,
  });

  final AnalysisResult result;
  final bool isExpanded;
  final bool isStale;
  final bool isTimeout;
  final bool isSaving;

  /// Rendered once below the card (deck §2.8 — first result only).
  final bool showDisclaimer;

  final VoidCallback onToggleExpand;
  final VoidCallback onSaveMeal;
  final VoidCallback onEditDescription;
  final void Function(int index, MealItem item) onItemTap;
  final VoidCallback onAddItem;
  final VoidCallback onTeaserTap;

  final VoidCallback? onReanalyze;
  final VoidCallback? onKeep;

  /// TODO(copy): result_kcal is a static deck example («~430 سعرة») with no
  /// {kcal} placeholder and no standalone unit key — passed in until the
  /// deck adds one (SummaryStrip.noGoalText precedent).
  final String? kcalUnitText;

  /// TODO(copy): compact gram unit «جم»/«g» has no standalone key — passed
  /// in until the deck adds one (SummaryStrip.noGoalText precedent).
  final String? macroUnitText;

  Verdict _chipVerdict(VerdictLevel level) {
    switch (level) {
      case VerdictLevel.balanced:
        return Verdict.balanced;
      case VerdictLevel.acceptable:
        return Verdict.acceptable;
      case VerdictLevel.lighten:
        return Verdict.lighten;
    }
  }

  // «~430» — LRI…PDI isolated, tilde before the number (deck §1.4).
  String _kcalLine() {
    final String number = '\u2066~${formatCalories(result.kcal)}\u2069';
    final String? unit = kcalUnitText;
    return unit == null ? number : '$number $unit';
  }

  // Macros rounded to whole numbers (deck §1.1); «22جم» compact (deck §3.4).
  String _macroValue(double grams) {
    final String number = '\u2066${grams.round()}\u2069';
    final String? unit = macroUnitText;
    return unit == null ? number : '$number$unit';
  }

  // «2 قطعة» / «150 جرام» — gram unit shows the resolved grams value, other
  // units show the multiplier; western digits isolated (states §3.3).
  String _amountText(BuildContext context, MealItem item) {
    final String unitLabel = switch (item.unit) {
      MealUnit.piece => context.translate(LangKeys.unitPiece),
      MealUnit.cup => context.translate(LangKeys.unitCup),
      MealUnit.gram => context.translate(LangKeys.unitGram),
      MealUnit.spoon => context.translate(LangKeys.unitSpoon),
    };
    final bool hasGrams = item.unit == MealUnit.gram && item.grams != null;
    final String quantity = hasGrams
        ? formatCalories(item.grams!)
        : _multiplier(item.quantityMultiplier);
    return '\u2066$quantity\u2069 $unitLabel';
  }

  // 2.0 → «2», 1.5 → «1.5».
  String _multiplier(double multiplier) {
    if (multiplier == multiplier.roundToDouble()) {
      return multiplier.toInt().toString();
    }
    return multiplier.toString();
  }

  // Vertical chevrons need no RTL mirroring (spec §5) — they flip on state.
  IconData get _expandChevron =>
      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down;

  // Forward chevron mirrored manually — chevron_right never flips alone.
  IconData _forwardChevron(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    return isRtl ? Icons.chevron_left : Icons.chevron_right;
  }

  Widget _divider(ColorScheme scheme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        verticalSpace(AppSpacing.s12),
        Divider(height: 1, thickness: 1, color: scheme.outlineVariant),
        verticalSpace(AppSpacing.s12),
      ],
    );
  }

  Widget _echoRow(BuildContext context, ColorScheme scheme) {
    return Row(
      children: <Widget>[
        TextApp(
          text: context.translate(LangKeys.resultEchoLabel),
          theme: context.textStyle.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeightHelper.semiBold,
            color: scheme.onSurfaceVariant,
          ),
        ),
        horizontalSpace(AppSpacing.s8),
        Expanded(
          child: TextApp(
            text: '«${result.descriptionEcho}»',
            maxLines: 1,
            textOverflow: TextOverflow.ellipsis,
            theme: context.textStyle.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeightHelper.regular,
              color: scheme.onSurface,
            ),
          ),
        ),
        horizontalSpace(AppSpacing.s8),
        const EstimateChip(),
      ],
    );
  }

  Widget _kcalRow(BuildContext context, ColorScheme scheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: TextApp(
            text: _kcalLine(),
            theme: context.textStyle.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeightHelper.semiBold,
              fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
              color: scheme.onSurface,
            ),
          ),
        ),
        horizontalSpace(AppSpacing.s8),
        VerdictChip(verdict: _chipVerdict(result.verdict)),
      ],
    );
  }

  Widget _detailsToggle(BuildContext context, ColorScheme scheme) {
    final BorderRadius borderRadius = BorderRadius.circular(AppRadius.small.r);
    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onToggleExpand,
        borderRadius: borderRadius,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 48.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextApp(
                text: context.translate(LangKeys.resultDetailsToggle),
                theme: context.textStyle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeightHelper.semiBold,
                  color: scheme.onSurface,
                ),
              ),
              horizontalSpace(AppSpacing.s8),
              Icon(_expandChevron, size: 24.r, color: scheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }

  Widget _teaserRow(BuildContext context, ColorScheme scheme) {
    final BorderRadius borderRadius = BorderRadius.circular(AppRadius.small.r);
    return Material(
      color: scheme.tertiaryContainer,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTeaserTap,
        borderRadius: borderRadius,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 48.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.s12.w),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextApp(
                    text: context.translate(LangKeys.lighterSwapCta),
                    theme: context.textStyle.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeightHelper.semiBold,
                      color: scheme.onTertiaryContainer,
                    ),
                  ),
                ),
                Icon(
                  _forwardChevron(context),
                  size: 20.r,
                  color: scheme.onTertiaryContainer,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _addItemRow(BuildContext context, ColorScheme scheme) {
    final BorderRadius borderRadius = BorderRadius.circular(AppRadius.small.r);
    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onAddItem,
        borderRadius: borderRadius,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 48.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.add, size: 18.r, color: scheme.primary),
              horizontalSpace(AppSpacing.s8),
              TextApp(
                text: context.translate(LangKeys.addItem),
                theme: context.textStyle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeightHelper.semiBold,
                  color: scheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _expandedSection(BuildContext context, ColorScheme scheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextApp(
          text: context.translate(LangKeys.correctionSectionTitle),
          theme: context.textStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeightHelper.semiBold,
            color: scheme.onSurface,
          ),
        ),
        verticalSpace(AppSpacing.s4),
        for (final (int index, MealItem item) in result.items.indexed) ...<Widget>[
          ItemRow(
            name: item.name,
            amountText: _amountText(context, item),
            kcalText: formatCalories(item.kcal),
            lowConfidence: item.isLowConfidence,
            edited: item.isEdited,
            onTap: () => onItemTap(index, item),
          ),
          verticalSpace(AppSpacing.s4),
        ],
        _addItemRow(context, scheme),
        verticalSpace(AppSpacing.s12),
        TextApp(
          text: context.translate(LangKeys.adviceLabel),
          theme: context.textStyle.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeightHelper.semiBold,
            color: scheme.onSurfaceVariant,
          ),
        ),
        verticalSpace(AppSpacing.s4),
        TextApp(
          text: result.advice,
          maxLines: 2,
          theme: context.textStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeightHelper.regular,
            color: scheme.onSurface,
          ),
        ),
        verticalSpace(AppSpacing.s8),
        TextApp(
          text: result.verdictWhy,
          theme: context.textStyle.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeightHelper.regular,
            color: scheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _saveButton(BuildContext context, ColorScheme scheme) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: FilledButton(
        onPressed: isSaving ? null : onSaveMeal,
        child: TextApp(
          text: context.translate(LangKeys.saveCta),
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
          theme: context.textStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeightHelper.medium,
            color: isSaving
                ? scheme.onSurface.withValues(alpha: 0.38)
                : scheme.onPrimary,
          ),
        ),
      ),
    );
  }

  Widget _editButton(BuildContext context, ColorScheme scheme) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: OutlinedButton(
        onPressed: onEditDescription,
        child: TextApp(
          text: context.translate(LangKeys.editDescription),
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
          theme: context.textStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeightHelper.medium,
            color: scheme.primary,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (isStale) ...<Widget>[
          StaleGuardNotice(
            onReanalyze: onReanalyze,
            onKeep: onKeep,
          ),
          verticalSpace(AppSpacing.s12),
        ],
        // TODO(copy): err_timeout_actions is one combined «إعادة المحاولة /
        // إلغاء» label and this API has no retry/cancel callbacks — actions
        // stay empty until the deck splits the key (states §1.3).
        if (isTimeout) ...<Widget>[
          ErrorCard(
            icon: Icons.schedule,
            title: context.translate(LangKeys.errTimeoutTitle),
            body: context.translate(LangKeys.errTimeoutBody),
          ),
          verticalSpace(AppSpacing.s12),
        ],
        Container(
          padding: EdgeInsets.all(AppSpacing.cardInner.w),
          decoration: BoxDecoration(
            color: scheme.surfaceContainer,
            borderRadius: BorderRadius.circular(AppRadius.medium.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _echoRow(context, scheme),
              _divider(scheme),
              _kcalRow(context, scheme),
              _divider(scheme),
              MacroRow(
                proteinText: _macroValue(result.proteinGrams),
                carbsText: _macroValue(result.carbsGrams),
                fatText: _macroValue(result.fatGrams),
              ),
              _divider(scheme),
              _detailsToggle(context, scheme),
              if (isExpanded) ...<Widget>[
                _divider(scheme),
                _expandedSection(context, scheme),
              ],
              if (result.verdict != VerdictLevel.balanced) ...<Widget>[
                verticalSpace(AppSpacing.s12),
                _teaserRow(context, scheme),
              ],
              verticalSpace(AppSpacing.s16),
              _saveButton(context, scheme),
              verticalSpace(AppSpacing.s12),
              _editButton(context, scheme),
            ],
          ),
        ),
        if (showDisclaimer) ...<Widget>[
          verticalSpace(AppSpacing.s8),
          TextApp(
            text: context.translate(LangKeys.disclaimerInline),
            textAlign: TextAlign.start,
            theme: context.textStyle.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeightHelper.regular,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}
