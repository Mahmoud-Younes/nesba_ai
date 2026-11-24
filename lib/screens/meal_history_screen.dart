import 'package:flutter/material.dart';

class MealHistoryScreen extends StatelessWidget {
  const MealHistoryScreen({this.showEmptyPreview = false, super.key});

  final bool showEmptyPreview;

  static const _sampleDays = <_SampleDay>[
    _SampleDay(
      label: 'Today',
      entries: [
        _SampleMeal(
          mealType: 'Breakfast',
          time: '8:15 AM',
          description: 'Warm oatmeal with berries and a little honey.',
        ),
        _SampleMeal(
          mealType: 'Lunch',
          time: '12:40 PM',
          description: 'Lentil soup with toasted bread on the side.',
        ),
      ],
    ),
    _SampleDay(
      label: 'Yesterday',
      entries: [
        _SampleMeal(
          mealType: 'Dinner',
          time: '7:05 PM',
          description: 'Grilled vegetables with rice and fresh herbs.',
        ),
        _SampleMeal(
          mealType: 'Snack',
          time: '3:20 PM',
          description: 'A crisp apple and a handful of almonds.',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal History'),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          key: const ValueKey('meal-history-scroll-view'),
          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildSampleNotice(theme),
                  const SizedBox(height: 20),
                  if (showEmptyPreview)
                    _buildEmptyPreview(theme)
                  else
                    for (var index = 0; index < _sampleDays.length; index++)
                      _buildDay(theme, _sampleDays[index], index),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSampleNotice(ThemeData theme) {
    final colors = theme.colorScheme;

    return Semantics(
      container: true,
      label:
          'Illustrative sample only. These entries are examples and are not saved or synchronized.',
      child: ExcludeSemantics(
        child: Material(
          color: colors.primaryContainer,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: colors.onPrimaryContainer),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Illustrative examples',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: colors.onPrimaryContainer,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'These entries are examples only. They are not saved or synced.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDay(ThemeData theme, _SampleDay day, int index) {
    return Padding(
      key: ValueKey('meal-history-day-$index'),
      padding: EdgeInsetsDirectional.only(
        bottom: index == _sampleDays.length - 1 ? 0 : 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            day.label,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          for (var mealIndex = 0; mealIndex < day.entries.length; mealIndex++)
            Padding(
              padding: EdgeInsetsDirectional.only(
                bottom: mealIndex == day.entries.length - 1 ? 0 : 10,
              ),
              child: _buildMealCard(theme, day.entries[mealIndex]),
            ),
        ],
      ),
    );
  }

  Widget _buildMealCard(ThemeData theme, _SampleMeal meal) {
    final colors = theme.colorScheme;

    return Semantics(
      container: true,
      label:
          'Example entry. ${meal.mealType} at ${meal.time}. ${meal.description}',
      child: ExcludeSemantics(
        child: Material(
          color: colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 4,
                  children: [
                    Text(
                      meal.mealType,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      meal.time,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(meal.description, style: theme.textTheme.bodyLarge),
                const SizedBox(height: 12),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      child: Text(
                        'Example entry',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyPreview(ThemeData theme) {
    final colors = theme.colorScheme;

    return Semantics(
      container: true,
      label: 'No examples are shown in this preview.',
      child: ExcludeSemantics(
        child: Material(
          color: colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Icon(
                  Icons.restaurant_outlined,
                  size: 36,
                  color: colors.primary,
                ),
                const SizedBox(height: 12),
                Text(
                  'No examples are shown in this preview.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SampleDay {
  const _SampleDay({required this.label, required this.entries});

  final String label;
  final List<_SampleMeal> entries;
}

class _SampleMeal {
  const _SampleMeal({
    required this.mealType,
    required this.time,
    required this.description,
  });

  final String mealType;
  final String time;
  final String description;
}
