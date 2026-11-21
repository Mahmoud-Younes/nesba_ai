import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/core/style/theme/app_radius.dart';

/// S09 meal-context banner (screen-specs §2.9, G-10): meal row plus a
/// back-to-meal text button — no push, the meal stays live in the log.
class MealContextBanner extends StatelessWidget {
  const MealContextBanner({
    required this.mealDescription,
    required this.onBackToMeal,
    this.backLabel,
    super.key,
  });

  final String mealDescription;
  final VoidCallback onBackToMeal;

  /// TODO(copy): no standalone back-label key (G-10 embeds it after «·»); when null the banner-key tail is reused.
  final String? backLabel;

  static const String _separator = '·';

  String _head(String template) {
    final int index = template.indexOf(_separator);
    return index < 0 ? template : template.substring(0, index);
  }

  String _tail(String template) {
    final int index = template.indexOf(_separator);
    return index < 0 ? '' : template.substring(index + _separator.length);
  }

  String _withMeal(String template, String meal) {
    return template
        .replaceAll('{وصف}', meal)
        .replaceAll('{meal}', meal);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final String template = context.translate(LangKeys.swapsMealContextBanner);
    final String bannerText = _withMeal(_head(template).trim(), mealDescription);
    final String label = backLabel ?? _tail(template).trim();
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppRadius.small.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.restaurant,
            size: 16.r,
            color: scheme.onPrimaryContainer,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextApp(
              text: bannerText,
              maxLines: 2,
              textOverflow: TextOverflow.ellipsis,
              theme: context.textStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeightHelper.semiBold,
                color: scheme.onPrimaryContainer,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          TextButton(
            onPressed: onBackToMeal,
            style: TextButton.styleFrom(
              foregroundColor: scheme.onPrimaryContainer,
              minimumSize: Size(48.w, 48.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Back direction handled manually: arrow points to the
                // start side in both directions.
                Icon(
                  isRtl ? Icons.arrow_forward : Icons.arrow_back,
                  size: 18.r,
                ),
                if (label.isNotEmpty) ...[
                  SizedBox(width: 4.w),
                  Flexible(
                    child: TextApp(
                      text: label,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                      theme: context.textStyle.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.semiBold,
                        color: scheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
