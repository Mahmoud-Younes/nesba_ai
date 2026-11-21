import 'package:flutter/material.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/widgets/feedback/empty_state.dart';

/// S08 first-run empty state (screen-specs §2.8): no-suggestions copy built
/// from live keys. TODO(copy-gap): the CTA bakes «سجّل» — a {tab} placeholder
/// pair needs deck-owner approval before the tab name renders live (§2.6).
class SwapsEmpties extends StatelessWidget {
  const SwapsEmpties({this.onCta, super.key});

  // TODO(log): screen wires this callback to switching to the Log tab.
  final VoidCallback? onCta;

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      title: context.translate(LangKeys.emptyNoSuggestionsTitle),
      body: context.translate(LangKeys.emptyNoSuggestionsBody),
      ctaLabel: context.translate(LangKeys.emptyNoSuggestionsCta),
      onCta: onCta,
    );
  }
}
