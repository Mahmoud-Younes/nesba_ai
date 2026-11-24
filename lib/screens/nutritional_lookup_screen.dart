import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NutritionalLookupScreen extends StatefulWidget {
  const NutritionalLookupScreen({super.key}) : _debugErrorPreview = false;

  @visibleForTesting
  const NutritionalLookupScreen.debugErrorPreview({super.key})
    : _debugErrorPreview = true;

  final bool _debugErrorPreview;

  @override
  State<NutritionalLookupScreen> createState() =>
      _NutritionalLookupScreenState();
}

enum _MealType { breakfast, lunch, dinner, snack }

enum _PreviewState { input, loading, result, error }

class _NutritionalLookupScreenState extends State<NutritionalLookupScreen> {
  static const _loadingDuration = Duration(milliseconds: 700);
  static const _mealTypeLabels = <_MealType, String>{
    _MealType.breakfast: 'Breakfast',
    _MealType.lunch: 'Lunch',
    _MealType.dinner: 'Dinner',
    _MealType.snack: 'Snack',
  };

  final _descriptionController = TextEditingController();
  final _descriptionFocusNode = FocusNode();
  Timer? _loadingTimer;
  _MealType? _selectedMealType;
  _PreviewState _previewState = _PreviewState.input;
  bool _showDescriptionError = false;

  @override
  void initState() {
    super.initState();
    if (widget._debugErrorPreview && kDebugMode) {
      _previewState = _PreviewState.error;
    }
  }

  @override
  void dispose() {
    _loadingTimer?.cancel();
    _descriptionController.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  void _analyze() {
    if (_descriptionController.text.trim().isEmpty) {
      setState(() => _showDescriptionError = true);
      _descriptionFocusNode.requestFocus();
      return;
    }

    _descriptionFocusNode.unfocus();
    _startLoading();
  }

  void _startLoading() {
    _loadingTimer?.cancel();
    setState(() {
      _showDescriptionError = false;
      _previewState = _PreviewState.loading;
    });
    _loadingTimer = Timer(_loadingDuration, () {
      if (mounted) setState(() => _previewState = _PreviewState.result);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Describe your meal',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Write what you ate in your own words.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildComposer(theme),
                  const SizedBox(height: 16),
                  _buildPreview(theme),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComposer(ThemeData theme) {
    final colors = theme.colorScheme;

    return Material(
      color: colors.surfaceContainer,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Meal Description',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              key: const ValueKey('meal-description'),
              controller: _descriptionController,
              focusNode: _descriptionFocusNode,
              minLines: 4,
              maxLines: 6,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: 'For example: lentil soup with a side of bread',
                alignLabelWithHint: true,
                errorText: _showDescriptionError
                    ? 'Please describe your meal.'
                    : null,
              ),
              onChanged: (_) {
                if (_showDescriptionError &&
                    _descriptionController.text.trim().isNotEmpty) {
                  setState(() => _showDescriptionError = false);
                }
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Meal Type (optional)',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Semantics(
              container: true,
              label: 'Meal Type. Optional. Choose one.',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final entry in _mealTypeLabels.entries)
                    ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 48),
                      child: ChoiceChip(
                        key: ValueKey('meal-type-${entry.key.name}'),
                        label: Text(entry.value),
                        selected: _selectedMealType == entry.key,
                        onSelected: (selected) {
                          setState(() {
                            _selectedMealType = selected ? entry.key : null;
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48),
              child: FilledButton(
                key: const ValueKey('analyze-button'),
                onPressed: _previewState == _PreviewState.loading
                    ? null
                    : _analyze,
                child: _previewState == _PreviewState.loading
                    ? const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          SizedBox(width: 12),
                          Flexible(child: Text('Preparing preview…')),
                        ],
                      )
                    : const Text('Analyze'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreview(ThemeData theme) {
    switch (_previewState) {
      case _PreviewState.input:
        return const SizedBox.shrink();
      case _PreviewState.loading:
        return Semantics(
          liveRegion: true,
          label: 'Preparing illustrative preview',
          child: const SizedBox(height: 1),
        );
      case _PreviewState.error:
        return _buildError(theme);
      case _PreviewState.result:
        return _buildIllustrativeResult(theme);
    }
  }

  Widget _buildError(ThemeData theme) {
    final colors = theme.colorScheme;
    return Semantics(
      liveRegion: true,
      container: true,
      label: 'Simulated preview error. Retry to show the illustrative sample.',
      child: Material(
        color: colors.errorContainer,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Preview unavailable',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colors.onErrorContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'This is a simulated preview error. No analysis service was contacted.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onErrorContainer,
                ),
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                key: const ValueKey('retry-button'),
                onPressed: _startLoading,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIllustrativeResult(ThemeData theme) {
    final colors = theme.colorScheme;
    const values = <(String, String)>[
      ('Energy', 'Illustrative: 520 kcal'),
      ('Protein', 'Illustrative: 38 g'),
      ('Carbohydrates', 'Illustrative: 54 g'),
      ('Fat', 'Illustrative: 16 g'),
    ];

    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: 'Illustrative sample only. Not calculated from your meal.',
      child: Material(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Illustrative sample only',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Not calculated from your meal.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),
              for (final (label, value) in values) ...[
                if (label != 'Energy')
                  Divider(color: colors.outlineVariant, height: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(label, style: theme.textTheme.bodyLarge),
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          value,
                          textAlign: TextAlign.end,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
