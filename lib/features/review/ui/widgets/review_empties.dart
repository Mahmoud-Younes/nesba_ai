import 'package:flutter/material.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/widgets/feedback/empty_state.dart';

/// Which review empty state to render (S06 §2.6 — deck §2.6 keys).
enum ReviewEmptyKind { firstRun, noMeals }

/// Review gate empties — firstRun / noMeals with neutral, no-blame copy
/// (states §1.5).
class ReviewEmpties extends StatelessWidget {
  const ReviewEmpties({required this.kind, required this.onCta, super.key});

  final ReviewEmptyKind kind;

  /// Single CTA — «سجّل أول وجبة» / «سجّل وجبة» → the Log tab.
  final VoidCallback? onCta;

  @override
  Widget build(BuildContext context) {
    return switch (kind) {
      ReviewEmptyKind.firstRun => EmptyState(
          title: context.translate(LangKeys.emptyFirstRunTitle),
          body: context.translate(LangKeys.emptyFirstRunBody),
          ctaLabel: context.translate(LangKeys.emptyFirstRunCta),
          onCta: onCta,
        ),
      ReviewEmptyKind.noMeals => EmptyState(
          title: context.translate(LangKeys.emptyNoMealsTitle),
          body: context.translate(LangKeys.emptyNoMealsBody),
          ctaLabel: context.translate(LangKeys.emptyNoMealsCta),
          onCta: onCta,
        ),
    };
  }
}
