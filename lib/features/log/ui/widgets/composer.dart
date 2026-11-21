import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/core/style/theme/app_radius.dart';

/// Meal composer (screen-specs §1.5): expanded outlined field or collapsed 48dp row.
class Composer extends StatelessWidget {
  const Composer({
    required this.controller,
    required this.focusNode,
    required this.isExpanded,
    this.onChanged,
    this.onExpand,
    this.onCollapse,
    this.onClear,
    this.showFirstRunHint = false,
    this.clearSemanticsLabel,
    super.key,
  });

  /// Draft controller owned by the screen (trim-before-validate lives there).
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isExpanded;
  final ValueChanged<String>? onChanged;

  /// Expands the collapsed row (spec §2.3).
  final VoidCallback? onExpand;

  /// Collapse trigger owned by the screen (e.g. after a result lands).
  final VoidCallback? onCollapse;
  final VoidCallback? onClear;

  /// First-run helper line (spec §2.1) — the screen hides it post first analysis.
  final bool showFirstRunHint;

  /// Clear button semantics label; defaults to the `log_clear` key.
  final String? clearSemanticsLabel;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    if (!isExpanded) {
      return _collapsedRow(context, scheme);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          minLines: 3,
          maxLines: null,
          textInputAction: TextInputAction.newline,
          decoration: InputDecoration(
            hintText: context.translate(LangKeys.logComposerPlaceholder),
            hintStyle: context.textStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeightHelper.regular,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: TextApp(
                text: context.translate(LangKeys.logComposerHint),
                maxLines: 2,
                theme: context.textStyle.copyWith(
                  fontSize: 12.sp,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
            _clearButton(context, scheme),
          ],
        ),
        if (showFirstRunHint) ...[
          SizedBox(height: 4.h),
          TextApp(
            text: context.translate(LangKeys.logFirstRunHint),
            maxLines: 2,
            theme: context.textStyle.copyWith(
              fontSize: 12.sp,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }

  // 48dp touch target, visible only when the trimmed draft is not empty.
  Widget _clearButton(BuildContext context, ColorScheme scheme) {
    final String label =
        clearSemanticsLabel ?? context.translate(LangKeys.logClear);
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        if (controller.text.trim().isEmpty) {
          return const SizedBox.shrink();
        }
        return Semantics(
          label: label,
          button: true,
          child: IconButton(
            onPressed: onClear,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(minWidth: 48.w, minHeight: 48.h),
            icon: Icon(
              Icons.clear,
              size: 24.r,
              color: scheme.onSurfaceVariant,
            ),
          ),
        );
      },
    );
  }

  // Collapsed: single 48dp row — clipped description + direction-aware chevron.
  Widget _collapsedRow(BuildContext context, ColorScheme scheme) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    final BorderRadius radius = BorderRadius.circular(AppRadius.small.r);
    return Material(
      color: Colors.transparent,
      borderRadius: radius,
      child: InkWell(
        onTap: onExpand,
        borderRadius: radius,
        child: SizedBox(
          height: 48.h,
          child: Row(
            children: [
              Expanded(
                child: TextApp(
                  text: controller.text,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                  theme: context.textStyle.copyWith(
                    fontSize: 14.sp,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                isRtl ? Icons.chevron_left : Icons.chevron_right,
                size: 24.r,
                color: scheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
