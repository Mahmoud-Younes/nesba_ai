import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';

/// Full-width quiet offline strip; [message] comes from the screen
/// (log_offline_banner / offline_saved_data_banner).
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Semantics(
      // liveRegion announces politely (aria-live polite equivalent).
      liveRegion: true,
      child: ExcludeFocus(
        child: Container(
          width: double.infinity,
          color: scheme.secondaryContainer,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.wifi_off,
                size: 18,
                color: scheme.onSecondaryContainer,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: TextApp(
                  text: message,
                  textAlign: TextAlign.start,
                  theme: context.textStyle.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeightHelper.regular,
                    color: scheme.onSecondaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
