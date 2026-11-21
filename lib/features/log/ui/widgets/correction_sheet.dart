import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/core/style/theme/app_radius.dart';
import 'package:nesba_ai/core/widgets/calorie_ring.dart';
import 'package:nesba_ai/core/widgets/chips/edited_chip.dart';
import 'package:nesba_ai/features/log/data/models/meal_item.dart';
import 'package:nesba_ai/features/log/ui/widgets/qty_stepper.dart';

/// S04 correction sheet (screen-specs §2.4): live portion/grams/unit editing
/// over a pinned totals footer; every change applies live via [onLiveChange],
/// «تم» just closes, delete is instant (the undo snackbar is the screen's
/// job). Open through [CorrectionSheet.show].
class CorrectionSheet extends StatefulWidget {
  const CorrectionSheet({
    required this.item,
    required this.mealBaseKcal,
    required this.mealProteinGrams,
    required this.mealCarbsGrams,
    required this.mealFatGrams,
    required this.doneLabel,
    required this.kcalUnitText,
    required this.mealTotalLabel,
    required this.macroUnitText,
    required this.onDelete,
    this.onAddItem,
    required this.onLiveChange,
    super.key,
  });

  /// Item being corrected — the immutable base for all live math.
  final MealItem item;

  /// kcal of the meal's other items (meal total minus [item]).
  final int mealBaseKcal;
  final double mealProteinGrams;
  final double mealCarbsGrams;
  final double mealFatGrams;

  /// Confirm button label («تم» — deck `done` key).
  final String doneLabel;

  /// kcal unit word appended after live numbers («سعرة» — deck key).
  final String kcalUnitText;

  /// Label before the live meal-kcal total («إجمالي الوجبة» — deck key).
  final String mealTotalLabel;

  /// Compact gram unit appended to live macro values («جم» — deck key).
  final String macroUnitText;

  final VoidCallback onDelete;

  /// «+ أضف عنصرًا» — screen-owned flow; button disables when null.
  final VoidCallback? onAddItem;

  /// Fires on every edit so the card behind the sheet updates live (spec
  /// §2.4: totals reflect immediately, without waiting for the close).
  final ValueChanged<MealItem>? onLiveChange;

  /// Modal entry: surfaceContainerLow, top corners 16, elevation 2, scrim
  /// from the theme; capped at 0.85 of screen height (spec §2.4).
  static Future<void> show(
    BuildContext context, {
    required MealItem item,
    required int mealBaseKcal,
    required double mealProteinGrams,
    required double mealCarbsGrams,
    required double mealFatGrams,
    required String doneLabel,
    required String kcalUnitText,
    required String mealTotalLabel,
    required String macroUnitText,
    required ValueChanged<MealItem> onLiveChange,
    required VoidCallback onDelete,
    VoidCallback? onAddItem,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      elevation: 2,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppRadius.large.r)),
      ),
      constraints: BoxConstraints(
        maxHeight: 0.85 * MediaQuery.sizeOf(context).height,
      ),
      builder: (_) => CorrectionSheet(
        item: item,
        mealBaseKcal: mealBaseKcal,
        mealProteinGrams: mealProteinGrams,
        mealCarbsGrams: mealCarbsGrams,
        mealFatGrams: mealFatGrams,
        doneLabel: doneLabel,
        kcalUnitText: kcalUnitText,
        mealTotalLabel: mealTotalLabel,
        macroUnitText: macroUnitText,
        onDelete: onDelete,
        onAddItem: onAddItem,
        onLiveChange: onLiveChange,
      ),
    );
  }

  @override
  State<CorrectionSheet> createState() => _CorrectionSheetState();
}

class _CorrectionSheetState extends State<CorrectionSheet> {
  /// Deck multiplier set (spec §2.4).
  static const List<double> _steps = <double>[0.5, 1.0, 1.5, 2.0];

  late double _multiplier;
  late MealUnit _selectedUnit;
  late final TextEditingController _gramsController;
  bool _edited = false;

  @override
  void initState() {
    super.initState();
    // 1x = the item exactly as analyzed (its stored kcal) — the stepper
    // scales FROM the current amount, it does not re-apply the quantity.
    _multiplier = 1.0;
    _selectedUnit = widget.item.unit;
    _gramsController =
        TextEditingController(text: widget.item.grams?.toString() ?? '');
    _edited = widget.item.isEdited;
  }

  @override
  void dispose() {
    _gramsController.dispose();
    super.dispose();
  }

  // Typed grams override the multiplier while the field is non-empty.
  int? _typedGrams() {
    final String text = _gramsController.text.trim();
    if (text.isEmpty) {
      return null;
    }
    return int.tryParse(text);
  }

  // kcal × grams ÷ original grams when both exist, else kcal × multiplier.
  int _liveKcal() {
    final int? grams = _typedGrams();
    final int baseGrams = widget.item.grams ?? 0;
    if (grams != null && baseGrams > 0) {
      return (widget.item.kcal * grams / baseGrams).round();
    }
    return (widget.item.kcal * _multiplier).round();
  }

  MealItem _liveItem() => widget.item.copyWith(
        // The multiplier adjusts the analyzed amount, not replaces it.
        quantityMultiplier: widget.item.quantityMultiplier * _multiplier,
        grams: _typedGrams() ?? widget.item.grams,
        unit: _selectedUnit,
        kcal: _liveKcal(),
        isEdited: _edited,
      );

  // «الأساس + الفرق»: mealBaseKcal + this item's live kcal.
  int _liveMealKcal() => widget.mealBaseKcal + _liveKcal();

  // The item's own macro share is unknown at this layer, so the meal macros
  // scale with the kcal ratio (base + proportional delta).
  double _macroScale() {
    final int baseMealKcal = widget.mealBaseKcal + widget.item.kcal;
    return baseMealKcal > 0 ? _liveMealKcal() / baseMealKcal : 1.0;
  }

  // Marks the item edited and pushes the live value to the screen.
  void _mutate(void Function() change) {
    setState(() {
      change();
      _edited = true;
    });
    widget.onLiveChange?.call(_liveItem());
  }

  void _step(int direction) {
    final int index = _steps.indexOf(_multiplier);
    final int current = index >= 0 ? index : _insertIndex(_multiplier);
    final int next = (current + direction).clamp(0, _steps.length - 1);
    _mutate(() {
      _multiplier = _steps[next];
      _gramsController.clear();
    });
  }

  // Nearest step position for a multiplier outside the deck set.
  int _insertIndex(double value) {
    for (int i = 0; i < _steps.length; i++) {
      if (value <= _steps[i]) {
        return i;
      }
    }
    return _steps.length - 1;
  }

  // Changes already applied live — closing commits nothing extra.
  void _handleDone() {
    Navigator.of(context).pop();
  }

  // Delete is instant — no confirm (spec §2.4); undo lives on the screen.
  void _handleDelete() {
    widget.onDelete();
    Navigator.of(context).pop();
  }

  String _macroText(String label, double grams) {
    final int value = (grams * _macroScale()).round();
    // Numeric run isolated LRI…PDI (states §3.3); unit hugs the digits.
    return '$label \u2066${formatCalories(value)}\u2069${widget.macroUnitText}';
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dragHandle(scheme),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(context, scheme),
                    SizedBox(height: 16.h),
                    QtyStepper(
                      value: _multiplier,
                      onMinus: () => _step(-1),
                      onPlus: () => _step(1),
                    ),
                    SizedBox(height: 16.h),
                    _gramsField(context, scheme),
                    SizedBox(height: 12.h),
                    _unitChips(context, scheme),
                    SizedBox(height: 16.h),
                    _liveKcalLine(context, scheme),
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
            ),
            _totalsFooter(context, scheme),
            _actionsRow(context, scheme),
          ],
        ),
      ),
    );
  }

  // Drag handle 32×4 on outlineVariant (spec §2.4).
  Widget _dragHandle(ColorScheme scheme) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Center(
        child: Container(
          width: 32.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: scheme.outlineVariant,
            borderRadius: BorderRadius.circular(AppRadius.stadium.r),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context, ColorScheme scheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Flexible(
              child: TextApp(
                text: widget.item.name,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
                theme: context.textStyle.copyWith(
                  fontSize: 22.sp,
                  fontWeight: FontWeightHelper.semiBold,
                  color: scheme.onSurface,
                ),
              ),
            ),
            if (_edited) ...[
              SizedBox(width: 8.w),
              const EditedChip(),
            ],
          ],
        ),
        SizedBox(height: 4.h),
        TextApp(
          text:
              '\u2066${formatCalories(_liveKcal())}\u2069 ${widget.kcalUnitText}',
          theme: context.textStyle.copyWith(
            fontSize: 16.sp,
            fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
            color: scheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  // Optional grams field: outlined, numeric, internally LTR (spec §2.4 RTL);
  // typing here overrides the multiplier and recalculates directly.
  Widget _gramsField(BuildContext context, ColorScheme scheme) {
    return SizedBox(
      height: 64.h,
      child: TextField(
        controller: _gramsController,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        textAlignVertical: TextAlignVertical.center,
        textDirection: TextDirection.ltr,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (_) => _mutate(() {}),
        decoration: InputDecoration(
          labelText: context.translate(LangKeys.itemAmountLabel),
          labelStyle: context.textStyle.copyWith(
            fontSize: 14.sp,
            color: scheme.onSurfaceVariant,
          ),
          suffixText: context.translate(LangKeys.unitGram),
          suffixStyle: context.textStyle.copyWith(
            fontSize: 14.sp,
            color: scheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _unitChips(BuildContext context, ColorScheme scheme) {
    return Wrap(
      spacing: 8.w,
      children: <Widget>[
        for (final MealUnit unit in MealUnit.values)
          _unitChip(context, scheme, unit),
      ],
    );
  }

  Widget _unitChip(BuildContext context, ColorScheme scheme, MealUnit unit) {
    final bool selected = _selectedUnit == unit;
    return FilterChip(
      selected: selected,
      showCheckmark: false,
      selectedColor: scheme.secondaryContainer,
      onSelected: (_) => _mutate(() => _selectedUnit = unit),
      label: TextApp(
        text: context.translate(_unitKey(unit)),
        theme: context.textStyle.copyWith(
          fontSize: 14.sp,
          fontWeight: selected
              ? FontWeightHelper.semiBold
              : FontWeightHelper.regular,
          color: selected ? scheme.onSecondaryContainer : scheme.onSurface,
        ),
      ),
    );
  }

  String _unitKey(MealUnit unit) => switch (unit) {
        MealUnit.piece => LangKeys.unitPiece,
        MealUnit.cup => LangKeys.unitCup,
        MealUnit.gram => LangKeys.unitGram,
        MealUnit.spoon => LangKeys.unitSpoon,
      };

  // «≈ 210 سعرة» — the ≈ stays while the value is still an estimate (§1.4).
  Widget _liveKcalLine(BuildContext context, ColorScheme scheme) {
    return TextApp(
      text: '≈ \u2066${formatCalories(_liveKcal())}\u2069 ${widget.kcalUnitText}',
      theme: context.textStyle.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeightHelper.semiBold,
        fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
        color: scheme.onSurface,
      ),
    );
  }

  // Pinned live totals (spec §2.4): meal kcal + the three macros, announced
  // politely once per change while the sheet is open.
  Widget _totalsFooter(BuildContext context, ColorScheme scheme) {
    return Semantics(
      liveRegion: true,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextApp(
              text:
                  '${widget.mealTotalLabel} \u2066${formatCalories(_liveMealKcal())}\u2069 ${widget.kcalUnitText}',
              theme: context.textStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeightHelper.semiBold,
                fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
                color: scheme.onSurface,
              ),
            ),
            SizedBox(height: 4.h),
            TextApp(
              text: '${_macroText(context.translate(LangKeys.macroProtein), widget.mealProteinGrams)}'
                  ' · ${_macroText(context.translate(LangKeys.macroCarbs), widget.mealCarbsGrams)}'
                  ' · ${_macroText(context.translate(LangKeys.macroFat), widget.mealFatGrams)}',
              theme: context.textStyle.copyWith(
                fontSize: 12.sp,
                fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Delete → add → done matches the focus order (spec §2.4 A11y).
  Widget _actionsRow(BuildContext context, ColorScheme scheme) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
      child: Row(
        children: [
          Flexible(
            child: OutlinedButton.icon(
              onPressed: _handleDelete,
              style: OutlinedButton.styleFrom(
                foregroundColor: scheme.error,
                side: BorderSide(color: scheme.error),
                minimumSize: Size(0, 48.h),
                padding: EdgeInsets.symmetric(horizontal: 12.w),
              ),
              icon: Icon(Icons.delete_outline, size: 20.r),
              label: TextApp(
                text: context.translate(LangKeys.removeItem),
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
                theme: context.textStyle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeightHelper.medium,
                  color: scheme.error,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Flexible(
            child: FilledButton.tonalIcon(
              onPressed: widget.onAddItem,
              style: FilledButton.styleFrom(
                minimumSize: Size(0, 48.h),
                padding: EdgeInsets.symmetric(horizontal: 12.w),
              ),
              icon: Icon(Icons.add, size: 20.r),
              label: TextApp(
                text: context.translate(LangKeys.addItem),
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
                theme: context.textStyle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeightHelper.medium,
                  color: scheme.onSecondaryContainer,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: SizedBox(
              height: 48.h,
              child: FilledButton(
                onPressed: _handleDone,
                child: TextApp(
                  text: widget.doneLabel,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                  theme: context.textStyle.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeightHelper.medium,
                    color: scheme.onPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
