import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const _patterns = <_PatternOption>[
    _PatternOption(
      value: 'vegetarian',
      label: 'Vegetarian',
      description: 'No meat or fish; dairy and eggs may be included.',
    ),
    _PatternOption(
      value: 'vegan',
      label: 'Vegan',
      description:
          'No foods from animals, including meat, fish, dairy, and eggs.',
    ),
    _PatternOption(
      value: 'pescatarian',
      label: 'Pescatarian',
      description:
          'Fish and seafood are okay; meat and poultry are not. Dairy and eggs may be included.',
    ),
  ];

  String? _selectedPattern;
  bool _glutenSelected = false;
  bool _dairyExplicitlySelected = false;
  bool _otherSelected = false;
  final TextEditingController _otherController = TextEditingController();

  @override
  void dispose() {
    _otherController.dispose();
    super.dispose();
  }

  void _setPattern(String? value) {
    if (value == null) return;
    setState(() => _selectedPattern = value);
  }

  void _setOtherSelected(bool selected) {
    if (!selected) FocusScope.of(context).unfocus();
    setState(() => _otherSelected = selected);
  }

  void _toggleDairy() =>
      setState(() => _dairyExplicitlySelected = !_dairyExplicitlySelected);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final veganSelected = _selectedPattern == 'vegan';

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Dietary preferences',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tell us what you prefer so future suggestions can take it into account.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Material(
                      color: colors.surfaceContainer,
                      borderRadius: BorderRadius.circular(12),
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Eating Pattern',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Choose one',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 4),
                            RadioGroup<String>(
                              groupValue: _selectedPattern,
                              onChanged: _setPattern,
                              child: Semantics(
                                container: true,
                                explicitChildNodes: true,
                                label: 'Eating Pattern. Choose one.',
                                child: Column(
                                  children: [
                                    for (final option in _patterns)
                                      RadioListTile<String>(
                                        key: ValueKey(
                                          'pattern-${option.value}',
                                        ),
                                        value: option.value,
                                        title: Text(option.label),
                                        subtitle: Text(option.description),
                                        contentPadding:
                                            EdgeInsetsDirectional.zero,
                                        visualDensity: VisualDensity.standard,
                                        activeColor: colors.primary,
                                        selected:
                                            _selectedPattern == option.value,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Divider(color: colors.outlineVariant, height: 1),
                            const SizedBox(height: 16),
                            Text(
                              'Ingredients to Avoid',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Choose any that apply',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 4),
                            CheckboxListTile(
                              key: const ValueKey('avoid-gluten'),
                              value: _glutenSelected,
                              onChanged: (value) => setState(
                                () => _glutenSelected = value ?? false,
                              ),
                              title: const Text(
                                'Gluten-containing ingredients',
                              ),
                              contentPadding: EdgeInsetsDirectional.zero,
                              visualDensity: VisualDensity.standard,
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            _buildDairyRow(veganSelected),
                            CheckboxListTile(
                              key: const ValueKey('avoid-other'),
                              value: _otherSelected,
                              onChanged: (value) =>
                                  _setOtherSelected(value ?? false),
                              title: const Text('Other'),
                              contentPadding: EdgeInsetsDirectional.zero,
                              visualDensity: VisualDensity.standard,
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            if (_otherSelected) ...[
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  start: 48,
                                  end: 8,
                                  bottom: 12,
                                ),
                                child: TextField(
                                  key: const ValueKey('other-details'),
                                  controller: _otherController,
                                  minLines: 2,
                                  maxLines: 4,
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.newline,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  decoration: const InputDecoration(
                                    labelText: 'Add details (optional)',
                                    alignLabelWithHint: true,
                                  ),
                                ),
                              ),
                            ],
                            const SizedBox(height: 8),
                            Divider(color: colors.outlineVariant, height: 1),
                            const SizedBox(height: 16),
                            Text(
                              'These preferences guide suggestions. They don’t guarantee that a meal or recipe is free from allergens.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colors.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDairyRow(bool veganSelected) {
    final colors = Theme.of(context).colorScheme;
    final semanticsLabel = veganSelected
        ? 'Dairy ingredients. Included with Vegan. Not a separate selection.'
        : 'Dairy ingredients';

    return Semantics(
      container: true,
      liveRegion: true,
      label: semanticsLabel,
      checked: veganSelected ? null : _dairyExplicitlySelected,
      enabled: !veganSelected,
      onTap: veganSelected ? null : _toggleDairy,
      child: ExcludeSemantics(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: veganSelected ? null : _toggleDairy,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 12, end: 8),
                child: Row(
                  children: [
                    if (veganSelected)
                      Icon(
                        Icons.info_outline_rounded,
                        color: colors.onSurfaceVariant,
                        size: 24,
                      )
                    else
                      IgnorePointer(
                        child: Checkbox(
                          key: const ValueKey('dairy-checkbox'),
                          value: _dairyExplicitlySelected,
                          onChanged: (_) {},
                          activeColor: colors.primary,
                          visualDensity: VisualDensity.standard,
                        ),
                      ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Dairy ingredients',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          if (veganSelected)
                            Text(
                              'Included with Vegan',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: colors.onSurfaceVariant),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PatternOption {
  const _PatternOption({
    required this.value,
    required this.label,
    required this.description,
  });

  final String value;
  final String label;
  final String description;
}
