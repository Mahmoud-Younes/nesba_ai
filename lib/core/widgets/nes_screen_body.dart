import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/helpers/spacing.dart';

/// The measure every gate shares: screen-edge gutter + a 480dp content
/// column centred on wider screens.
///
/// Phones render it edge-to-edge (390dp frame minus two 16dp gutters is
/// under the cap); tablets and the 200% text-scale pass stop the line
/// length from running away. Padding is directional so the gutter mirrors
/// in RTL without a second code path (states §3.1).
class NesScreenBody extends StatelessWidget {
  const NesScreenBody({
    required this.child,
    this.padding,
    this.scrollable = true,
    this.controller,
    super.key,
  });

  final Widget child;

  /// Defaults to the 16dp screen edge with a 24dp tail so the last card
  /// clears the nav bar.
  final EdgeInsetsDirectional? padding;

  /// False when the child scrolls itself (a `ListView.builder` list, or a
  /// `Column` with an `Expanded` list inside it).
  final bool scrollable;

  final ScrollController? controller;

  /// Line-length cap — the same 480 the Bustan screens are drawn against.
  static const double maxContentWidth = 480;

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsDirectional resolved =
        padding ??
        EdgeInsetsDirectional.fromSTEB(
          AppSpacing.screenEdge.w,
          AppSpacing.screenEdge.h,
          AppSpacing.screenEdge.w,
          AppSpacing.sectionDivider.h,
        );

    final Widget measured = Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxContentWidth.w),
        child: child,
      ),
    );

    if (!scrollable) {
      return Padding(padding: resolved, child: measured);
    }

    return SingleChildScrollView(
      controller: controller,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: resolved,
      child: measured,
    );
  }
}
