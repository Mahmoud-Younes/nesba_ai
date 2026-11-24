import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key});

  static const _sampleMealDescription =
      'Two eggs, brown toast and orange juice';
  static const _nutritionValues = <_NutritionValue>[
    _NutritionValue(label: 'Energy (kcal)', value: 'Illustrative: 430'),
    _NutritionValue(label: 'Protein (g)', value: 'Illustrative: 22'),
    _NutritionValue(label: 'Carbohydrates (g)', value: 'Illustrative: 48'),
    _NutritionValue(label: 'Fat (g)', value: 'Illustrative: 17'),
  ];
  static const _sampleItems = <_AnalyzedItem>[
    _AnalyzedItem(
      name: 'Eggs',
      quantity: 'Example quantity: 2 eggs',
      value: 'Illustrative value: 140 kcal',
    ),
    _AnalyzedItem(
      name: 'Brown toast',
      quantity: 'Example quantity: 2 slices',
      value: 'Illustrative value: 160 kcal',
    ),
    _AnalyzedItem(
      name: 'Orange juice',
      quantity: 'Example quantity: 250 ml',
      value: 'Illustrative value: 130 kcal',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Detail'),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildMealContext(theme),
                  const SizedBox(height: 20),
                  _buildNutritionSnapshot(theme),
                  const SizedBox(height: 20),
                  _buildAnalyzedItems(theme),
                  const SizedBox(height: 20),
                  _buildRecommendation(theme),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMealContext(ThemeData theme) {
    final colors = theme.colorScheme;

    return Column(
      key: const ValueKey('meal-context-section'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Meal context',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Material(
          color: colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Semantics(
                  container: true,
                  explicitChildNodes: true,
                  label:
                      'Illustrative sample only. Nothing on this screen was analyzed or calculated from a meal.',
                  child: Material(
                    color: colors.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Illustrative sample only',
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: colors.onPrimaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Nothing here was analyzed or calculated from a meal.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Meal Description',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Semantics(
                  label: 'Example meal description: $_sampleMealDescription',
                  child: Text(
                    _sampleMealDescription,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: 16),
                Divider(color: colors.outlineVariant, height: 1),
                const SizedBox(height: 12),
                Text(
                  'Meal Type',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text('Breakfast', style: theme.textTheme.bodyLarge),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionSnapshot(ThemeData theme) {
    final colors = theme.colorScheme;

    return Column(
      key: const ValueKey('nutrition-snapshot-section'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Nutrition snapshot',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Material(
          color: colors.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Illustrative values · not calculated from the meal',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                for (var index = 0; index < _nutritionValues.length; index++)
                  _buildNutritionRow(
                    theme,
                    _nutritionValues[index],
                    showDivider: index > 0,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionRow(
    ThemeData theme,
    _NutritionValue item, {
    required bool showDivider,
  }) {
    final colors = theme.colorScheme;

    return MergeSemantics(
      child: Column(
        children: [
          if (showDivider) Divider(color: colors.outlineVariant, height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(item.label, style: theme.textTheme.bodyLarge),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    item.value,
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
      ),
    );
  }

  Widget _buildAnalyzedItems(ThemeData theme) {
    final colors = theme.colorScheme;

    return Column(
      key: const ValueKey('analyzed-items-section'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Analyzed items',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Examples only; items and quantities are not detected or verified.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        for (var index = 0; index < _sampleItems.length; index++)
          _buildAnalyzedItem(
            theme,
            _sampleItems[index],
            showDivider: index > 0,
          ),
      ],
    );
  }

  Widget _buildAnalyzedItem(
    ThemeData theme,
    _AnalyzedItem item, {
    required bool showDivider,
  }) {
    final colors = theme.colorScheme;

    return MergeSemantics(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showDivider) Divider(color: colors.outlineVariant, height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.quantity,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(item.value, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendation(ThemeData theme) {
    final colors = theme.colorScheme;

    return Column(
      key: const ValueKey('recommendation-section'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Recommendation',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Material(
          color: colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Illustrative suggestion · not personalized',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'One optional variation is to serve the meal with a different side, such as roasted vegetables.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NutritionValue {
  const _NutritionValue({required this.label, required this.value});

  final String label;
  final String value;
}

class _AnalyzedItem {
  const _AnalyzedItem({
    required this.name,
    required this.quantity,
    required this.value,
  });

  final String name;
  final String quantity;
  final String value;
}
