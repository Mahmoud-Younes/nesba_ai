import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/core/widgets/calorie_ring.dart';
import 'package:nesba_ai/core/widgets/chips/estimate_chip.dart';
import 'package:nesba_ai/core/widgets/chips/fit_chip.dart';

/// Pair comparison card, side-by-side kept verbatim (spec §2.8): start
/// half «وجبتك» surfaceContainerLow / end half «البديل» tertiaryContainer,
/// savings + EstimateChip + FitChip + try line, then the 48dp actions.
class SwapPairCard extends StatelessWidget {
  const SwapPairCard({
    required this.pair,
    required this.isBookmarked,
    required this.onSwap,
    required this.onBookmark,
    super.key,
  });

  final Map<String, dynamic> pair;

  /// Drives Icons.bookmark ↔ Icons.bookmark_border.
  final bool isBookmarked;

  final VoidCallback onSwap;
  final VoidCallback onBookmark;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              Expanded(child: _half(context, isOriginal: true)),
              Container(width: 1.w, color: scheme.outlineVariant),
              Expanded(child: _half(context, isOriginal: false)),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8.w,
                  runSpacing: 4.h,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    TextApp(
                      // Per-pair delta through the deck's {value} key — the
                      // "~" drops out because the mock ships an exact number.
                      text: context
                          .translate(LangKeys.savingsLine)
                          .replaceAll(
                            '{value}',
                            formatCalories(
                              (pair['savings'] as num? ?? 0).toInt(),
                            ),
                          )
                          .replaceAll('~', ''),
                      theme: context.textStyle.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.semiBold,
                        color: scheme.onSurface,
                      ),
                    ),
                    const EstimateChip(),
                    if (pair['hasFit'] as bool? ?? false) const FitChip(),
                  ],
                ),
                SizedBox(height: 4.h),
                TextApp(
                  text: context.translate(LangKeys.tryLine),
                  theme: context.textStyle.copyWith(
                    fontSize: 12.sp,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 8.h),
                _actions(context, scheme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Side-by-side halves at 50/50 with the 1px divider between (§2.8).
  Widget _half(BuildContext context, {required bool isOriginal}) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Color background = isOriginal
        ? scheme.surfaceContainerLow
        : scheme.tertiaryContainer;
    final Color foreground = isOriginal
        ? scheme.onSurface
        : scheme.onTertiaryContainer;
    return Container(
      color: background,
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextApp(
            text: context.translate(
              isOriginal ? LangKeys.pairOriginal : LangKeys.pairAlternative,
            ),
            theme: context.textStyle.copyWith(
              fontSize: 12.sp,
              color: isOriginal
                  ? scheme.onSurfaceVariant
                  : scheme.onTertiaryContainer,
            ),
          ),
          SizedBox(height: 4.h),
          TextApp(
            text:
                pair[isOriginal ? 'original_name' : 'alt_name'] as String? ??
                '',
            maxLines: 2,
            theme: context.textStyle.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeightHelper.medium,
              color: foreground,
            ),
          ),
          SizedBox(height: 4.h),
          TextApp(
            // Bare number like the meals ledger — the unit copy lives in
            // the section line (savings_line), not per-half.
            text: formatCalories(
              (pair[isOriginal ? 'original_kcal' : 'alt_kcal'] as num? ?? 0)
                  .toInt(),
            ),
            theme: context.textStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeightHelper.semiBold,
              fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }

  // «تبديل» filled tertiary (food accent) + 48dp bookmark icon toggle.
  Widget _actions(BuildContext context, ColorScheme scheme) {
    return Row(
      children: <Widget>[
        FilledButton(
          onPressed: onSwap,
          style: FilledButton.styleFrom(
            backgroundColor: scheme.tertiary,
            foregroundColor: scheme.onTertiary,
            minimumSize: Size(0, 48.h),
            padding: EdgeInsets.symmetric(horizontal: 24.w),
          ),
          child: TextApp(
            text: context.translate(LangKeys.swapCta),
            theme: context.textStyle.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeightHelper.medium,
              color: scheme.onTertiary,
            ),
          ),
        ),
        const Spacer(),
        Semantics(
          label: context.translate(LangKeys.bookmarkCta),
          button: true,
          toggled: isBookmarked,
          child: IconButton(
            onPressed: onBookmark,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(minWidth: 48.w, minHeight: 48.h),
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              size: 24.r,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
