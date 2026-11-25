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
    // Intrinsic height — a horizontal viewport inside this unbounded column
    // cannot resolve its own height; a row grows with 200% text scale (states §5.2).
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        children: <Widget>[
          for (int index = 0; index < examples.length; index++) ...[
            if (index > 0) SizedBox(width: 8.w),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48),
              child: Material(
                color: scheme.secondaryContainer,
                borderRadius: borderRadius,
                child: InkWell(
                  onTap: onExampleTap == null
                      ? null
                      : () => onExampleTap!(examples[index]),
                  borderRadius: borderRadius,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    child: Center(
                      child: TextApp(
                        text: examples[index],
                        textAlign: TextAlign.start,
                        theme: context.textStyle.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeightHelper.semiBold,
                          color: scheme.onSecondaryContainer,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
