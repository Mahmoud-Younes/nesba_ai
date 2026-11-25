import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

/// Ledger sync states: ok / pending / failed (failed is retry-tappable).
enum SyncStatus { ok, pending, failed }

class SyncBadge extends StatelessWidget {
  const SyncBadge({required this.status, this.onRetry, super.key});
  final SyncStatus status;
  final VoidCallback? onRetry;

  String _label(BuildContext context) {
    switch (status) {
      case SyncStatus.ok:
        return context.translate(LangKeys.syncOk);
      case SyncStatus.pending:
        return context.translate(LangKeys.syncPending);
      case SyncStatus.failed:
        return context.translate(LangKeys.syncFailed);
    }
  }

  (Color, Color, IconData) _visual(ColorScheme scheme) {
    switch (status) {
      case SyncStatus.ok:
        return (
          scheme.secondaryContainer,
          scheme.onSecondaryContainer,
          Icons.check,
        );
      case SyncStatus.pending:
        return (
          scheme.secondaryContainer,
          scheme.onSecondaryContainer,
          Icons.schedule,
        );
      case SyncStatus.failed:
        return (
          scheme.errorContainer,
          scheme.onErrorContainer,
          Icons.sync_problem,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final (background, onBackground, icon) =
        _visual(Theme.of(context).colorScheme);
    final borderRadius = BorderRadius.circular(4.r);
    final content = Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, size: 14, color: onBackground),
          SizedBox(width: 4.w),
          Flexible(
            child: TextApp(
              text: _label(context),
              textAlign: TextAlign.start,
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
              theme: context.textStyle.copyWith(
                fontSize: 11.sp,
                fontWeight: FontWeightHelper.semiBold,
                color: onBackground,
              ),
            ),
          ),
        ],
      ),
    );
    final tappable = status == SyncStatus.failed && onRetry != null;
    if (!tappable) {
      return Container(
        decoration: BoxDecoration(
          color: background,
          borderRadius: borderRadius,
        ),
        child: content,
      );
    }
    return Material(
      color: background,
      borderRadius: borderRadius,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48),
        child: InkWell(
          onTap: onRetry,
          borderRadius: borderRadius,
          child: content,
        ),
      ),
    );
  }
}
