import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/helpers/spacing.dart';
import 'package:nesba_ai/core/style/fonts/app_type_scale.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/core/style/theme/app_radius.dart';

/// First-run example chips; texts come from [examples].
///
/// Wraps rather than scrolls sideways. Inside the composer card a
/// horizontal viewport clipped the last chip against the card edge, which
/// reads as a layout fault rather than as "there is more"; wrapping also
/// keeps every chip reachable at 200% text scale instead of pushing them
/// off a scroll axis nobody thinks to drag.
class ExampleChips extends StatelessWidget {
  const ExampleChips({required this.examples, this.onExampleTap, super.key});

  final List<String> examples;
  final ValueChanged<String>? onExampleTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final BorderRadius borderRadius = BorderRadius.circular(AppRadius.small.r);

    return Wrap(
      spacing: AppSpacing.s8.w,
      runSpacing: AppSpacing.s8.h,
      children: <Widget>[
        for (final String example in examples)
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48),
            child: Material(
              color: scheme.secondaryContainer,
              borderRadius: borderRadius,
              child: InkWell(
                onTap: onExampleTap == null
                    ? null
                    : () => onExampleTap!(example),
                borderRadius: borderRadius,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.s12.w,
                    vertical: AppSpacing.s8.h,
                  ),
                  // widthFactor pins the chip to its text. Without it
                  // Center expands to the Wrap's full line width and every
                  // chip claims a row of its own.
                  child: Center(
                    widthFactor: 1,
                    child: TextApp(
                      text: example,
                      textAlign: TextAlign.start,
                      theme: context.textStyle.copyWith(
                        fontSize: AppTypeScale.labelMedium.sp,
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
    );
  }
}
