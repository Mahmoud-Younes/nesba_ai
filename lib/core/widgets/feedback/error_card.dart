import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

/// Error card covering the five deck §2.7 variants via
/// [title]/[body]/[actions] parameters.
class ErrorCard extends StatelessWidget {
  const ErrorCard({
    required this.icon,
    required this.title,
    required this.body,
    this.actions = const [],
    super.key,
  });

  final IconData icon;
  final String title;
  final String body;

  /// label/onPressed pairs; deck §2.7 keeps one primary action per state.
  final List<(String, VoidCallback?)> actions;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: scheme.errorContainer,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon, size: 20, color: scheme.onErrorContainer),
              SizedBox(width: 8.w),
              Expanded(
                child: TextApp(
                  text: title,
                  textAlign: TextAlign.start,
                  theme: context.textStyle.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeightHelper.semiBold,
                    color: scheme.onErrorContainer,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          TextApp(
            text: body,
            textAlign: TextAlign.start,
            theme: context.textStyle.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeightHelper.regular,
              color: scheme.onErrorContainer,
            ),
          ),
          if (actions.isNotEmpty) ...[
            SizedBox(height: 4.h),
            Wrap(
              alignment: WrapAlignment.end,
              spacing: 8.w,
              runSpacing: 4.h,
              children: [
                for (final (String label, VoidCallback? onPressed) in actions)
                  TextButton(
                    onPressed: onPressed,
                    style: TextButton.styleFrom(
                      foregroundColor: scheme.onErrorContainer,
                      minimumSize: Size(48.w, 48.h),
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                    ),
                    child: TextApp(
                      text: label,
                      theme: context.textStyle.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeightHelper.semiBold,
                        color: scheme.onErrorContainer,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
