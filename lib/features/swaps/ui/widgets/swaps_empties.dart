import 'package:flutter/material.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/widgets/feedback/empty_state.dart';

/// S08 first-run empty state (screen-specs §2.8): no-suggestions copy built
/// from live keys — the tab name comes from `tab_log`, never static text.
class SwapsEmpties extends StatelessWidget {
  const SwapsEmpties({this.onCta, super.key});

  // TODO(log): screen wires this callback to switching to the Log tab.
  final VoidCallback? onCta;

  String _withTab(String template, String tabName) =>
      template.replaceAll('{tab}', tabName);

  @override
  Widget build(BuildContext context) {
    final String logTabName = context.translate(LangKeys.tabLog);
    return EmptyState(
      title: context.translate(LangKeys.emptyNoSuggestionsTitle),
      body: _withTab(
        context.translate(LangKeys.emptyNoSuggestionsBody),
        logTabName,
      ),
      ctaLabel: _withTab(
        context.translate(LangKeys.emptyNoSuggestionsCta),
        logTabName,
      ),
      onCta: onCta,
    );
  }
}
