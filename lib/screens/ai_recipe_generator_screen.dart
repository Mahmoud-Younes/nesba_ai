import 'dart:async';

import 'package:flutter/material.dart';

class AIRecipeGeneratorScreen extends StatefulWidget {
  const AIRecipeGeneratorScreen({
    required this.originalMealDescription,
    this.preferenceContext = const [],
    this.isSampleContext = false,
    super.key,
  });

  final String originalMealDescription;
  final List<String> preferenceContext;
  final bool isSampleContext;

  @override
  State<AIRecipeGeneratorScreen> createState() =>
      _AIRecipeGeneratorScreenState();
}

enum _PreviewState { initial, loading, result }

class _AIRecipeGeneratorScreenState extends State<AIRecipeGeneratorScreen> {
  static const _loadingDuration = Duration(milliseconds: 700);
  static const _ingredients = <String>[
    'Chickpeas',
    'Brown rice',
    'Roasted vegetables',
  ];
  static const _preparationSteps = <String>[
    'Roast the vegetables until tender.',
    'Warm the chickpeas and rice.',
    'Serve the chickpeas and vegetables over the rice.',
  ];

  Timer? _loadingTimer;
  _PreviewState _previewState = _PreviewState.initial;

  List<String> get _availablePreferences => widget.preferenceContext
      .where((preference) => preference.trim().isNotEmpty)
      .toList(growable: false);

  @override
  void dispose() {
    _loadingTimer?.cancel();
    super.dispose();
  }

  void _generatePreview() {
    if (_previewState == _PreviewState.loading) return;

    _loadingTimer?.cancel();
    setState(() => _previewState = _PreviewState.loading);
    _loadingTimer = Timer(_loadingDuration, () {
      if (mounted) setState(() => _previewState = _PreviewState.result);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alternative recipe'),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          key: const ValueKey('ai-recipe-scroll-view'),
          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Find an alternative',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start with a meal you selected.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildOriginalMeal(theme),
                  if (_availablePreferences.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _buildPreferenceContext(theme),
                  ],
                  if (widget.isSampleContext) ...[
                    const SizedBox(height: 12),
                    _buildSampleContextNotice(theme),
                  ],
                  const SizedBox(height: 20),
                  _buildGenerateButton(theme),
                  if (_previewState == _PreviewState.loading) ...[
                    const SizedBox(height: 12),
                    _buildLoadingNotice(theme),
                  ],
                  if (_previewState == _PreviewState.result) ...[
                    const SizedBox(height: 24),
                    _buildRecipePreview(theme),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOriginalMeal(ThemeData theme) {
    final colors = theme.colorScheme;

    return Material(
      key: const ValueKey('original-meal-card'),
      color: colors.surfaceContainerLow,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              header: true,
              child: Text(
                'Original meal',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.originalMealDescription,
              key: const ValueKey('original-meal-description'),
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferenceContext(ThemeData theme) {
    final colors = theme.colorScheme;

    return Semantics(
      key: const ValueKey('preference-context-section'),
      container: true,
      explicitChildNodes: true,
      label: 'Preference context supplied for this request',
      child: Material(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Preference context',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _availablePreferences.join(' · '),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSampleContextNotice(ThemeData theme) {
    final colors = theme.colorScheme;

    return Semantics(
      container: true,
      label: 'Sample data for the standalone preview only',
      child: Material(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            'Example meal and preference context for this preview only.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.onPrimaryContainer,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenerateButton(ThemeData theme) {
    final isLoading = _previewState == _PreviewState.loading;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: FilledButton(
        key: const ValueKey('generate-recipe-button'),
        onPressed: isLoading ? null : _generatePreview,
        child: isLoading
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      'Preparing preview…',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            : const Text('Generate recipe'),
      ),
    );
  }

  Widget _buildLoadingNotice(ThemeData theme) {
    return Semantics(
      key: const ValueKey('preview-loading-status'),
      container: true,
      liveRegion: true,
      label: 'Preparing an illustrative recipe preview. No AI service used.',
      child: Text(
        'This is a simulated preview; no recipe-generation service is used.',
        textAlign: TextAlign.center,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildRecipePreview(ThemeData theme) {
    final colors = theme.colorScheme;

    return Semantics(
      key: const ValueKey('alternative-recipe-preview'),
      container: true,
      liveRegion: true,
      explicitChildNodes: true,
      label:
          'Illustrative alternative recipe preview. Sample content only; not AI generated, not personalized, and not nutrition verified.',
      child: Material(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Semantics(
                header: true,
                child: Text(
                  'Alternative recipe preview',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Illustrative sample only',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Not generated by AI; not personalized or nutrition verified.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Chickpea and roasted vegetable bowl',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Illustrative ingredients',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              for (final ingredient in _ingredients)
                Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 4),
                  child: Text(
                    '• $ingredient',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              const SizedBox(height: 12),
              Text(
                'Illustrative preparation steps',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              for (var index = 0; index < _preparationSteps.length; index++)
                Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 8),
                  child: Text(
                    '${index + 1}. ${_preparationSteps[index]}',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
