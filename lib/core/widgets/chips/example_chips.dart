import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

/// Horizontal scrollable first-run example chips; texts come from [examples].
class ExampleChips extends StatelessWidget {
  const ExampleChips({required this.examples, this.onExampleTap, super.key});
  final List<String> examples;
  final ValueChanged<String>? onExampleTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final borderRadius = BorderRadius.circular(8.r);
    // Floor only — grows with 200% text scale instead of clipping (states §5.2).
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemCount: examples.length,
        separatorBuilder: (_, _) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final example = examples[index];
          return Material(
            color: scheme.secondaryContainer,
            borderRadius: borderRadius,
            child: InkWell(
              onTap:
                  onExampleTap == null ? null : () => onExampleTap!(example),
              borderRadius: borderRadius,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextApp(
                      text: example,
                      textAlign: TextAlign.start,
                      theme: context.textStyle.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeightHelper.semiBold,
                        color: scheme.onSecondaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
