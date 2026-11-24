import 'package:flutter/material.dart';

import 'screens/ai_recipe_generator_screen.dart';
import 'screens/login_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/meal_history_screen.dart';
import 'screens/nutritional_lookup_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/register_screen.dart';
import 'screens/snack_discovery_screen.dart';
import 'theme/bustan_theme.dart';

void main() {
  runApp(const DemoPreviewApp());
}

class DemoPreviewApp extends StatelessWidget {
  const DemoPreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Screen demo',
      debugShowCheckedModeBanner: false,
      theme: BustanTheme.light(),
      home: const DemoLauncherScreen(),
    );
  }
}

class DemoLauncherScreen extends StatelessWidget {
  const DemoLauncherScreen({super.key});

  static const _sections = <_DemoSectionData>[
    _DemoSectionData(
      title: 'Getting started',
      screens: [
        _DemoScreenData(
          id: 'onboarding',
          title: 'Onboarding',
          description: 'Explore dietary preferences and restrictions.',
          icon: Icons.tune,
          builder: _buildOnboarding,
        ),
        _DemoScreenData(
          id: 'login',
          title: 'Login',
          description: 'Email, password, and UI-only Google button.',
          icon: Icons.login,
          builder: _buildLogin,
        ),
        _DemoScreenData(
          id: 'register',
          title: 'Register',
          description: 'Create-account form preview; no account is created.',
          icon: Icons.person_add_alt_1,
          builder: _buildRegister,
        ),
      ],
    ),
    _DemoSectionData(
      title: 'Meal tracking',
      screens: [
        _DemoScreenData(
          id: 'nutritional-lookup',
          title: 'Nutritional Lookup',
          description: 'Describe a meal and view an illustrative result.',
          icon: Icons.edit_note,
          builder: _buildNutritionalLookup,
        ),
        _DemoScreenData(
          id: 'meal-history',
          title: 'Meal History',
          description: 'Browse clearly labeled sample meal entries.',
          icon: Icons.history,
          builder: _buildMealHistory,
        ),
        _DemoScreenData(
          id: 'meal-detail',
          title: 'Meal Detail',
          description: 'Review an illustrative meal detail preview.',
          icon: Icons.receipt_long,
          builder: _buildMealDetail,
        ),
      ],
    ),
    _DemoSectionData(
      title: 'Ideas and alternatives',
      screens: [
        _DemoScreenData(
          id: 'ai-recipe-generator',
          title: 'AI Recipe Generator',
          description: 'Explore a sample alternative recipe preview.',
          icon: Icons.menu_book_outlined,
          builder: _buildAIRecipeGenerator,
        ),
        _DemoScreenData(
          id: 'snack-discovery',
          title: 'Snack Discovery',
          description: 'Enter a craving and explore an illustrative idea.',
          icon: Icons.lightbulb_outline,
          builder: _buildSnackDiscovery,
        ),
      ],
    ),
  ];

  static Widget _buildOnboarding() => const OnboardingScreen();
  static Widget _buildLogin() => const LoginScreen();
  static Widget _buildRegister() => const RegisterScreen();
  static Widget _buildNutritionalLookup() => const NutritionalLookupScreen();
  static Widget _buildMealHistory() => const _MealHistoryDemoRoute();
  static Widget _buildMealDetail() => const MealDetailScreen();
  static Widget _buildAIRecipeGenerator() => const AIRecipeGeneratorScreen(
    originalMealDescription: 'Two eggs, brown toast and orange juice',
    isSampleContext: true,
  );
  static Widget _buildSnackDiscovery() =>
      const SnackDiscoveryScreen(isSamplePreview: true);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen demo'),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Material(
                    color: colors.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Eight screen previews',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: colors.onPrimaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'A UI-only walkthrough of the completed screens. Sample interactions do not connect to accounts, services, or saved data.',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: colors.onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Open a screen, then use Android Back to return here.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colors.onPrimaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  for (final section in _sections) ...[
                    Text(
                      section.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    for (final screen in section.screens)
                      _DemoScreenTile(
                        screen: screen,
                        onTap: () => Navigator.of(context).push<void>(
                          MaterialPageRoute<void>(
                            builder: (_) => screen.builder(),
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MealHistoryDemoRoute extends StatelessWidget {
  const _MealHistoryDemoRoute();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: const MealHistoryScreen(),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Separate illustrative sample content',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                key: const ValueKey('demo-open-meal-detail'),
                onPressed: () => Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (_) => const MealDetailScreen(),
                  ),
                ),
                icon: const Icon(Icons.open_in_new),
                label: const Text('Open Meal Detail sample'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DemoScreenTile extends StatelessWidget {
  const _DemoScreenTile({required this.screen, required this.onTap});

  final _DemoScreenData screen;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      key: ValueKey('demo-screen-${screen.id}'),
      color: colors.surfaceContainerLow,
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: onTap,
        leading: Icon(screen.icon, color: colors.primary),
        title: Text(screen.title),
        subtitle: Text(screen.description),
        trailing: const Icon(Icons.chevron_right),
        minTileHeight: 72,
        contentPadding: const EdgeInsetsDirectional.only(
          start: 16,
          end: 12,
          top: 4,
          bottom: 4,
        ),
      ),
    );
  }
}

class _DemoSectionData {
  const _DemoSectionData({required this.title, required this.screens});

  final String title;
  final List<_DemoScreenData> screens;
}

class _DemoScreenData {
  const _DemoScreenData({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.builder,
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Widget Function() builder;
}
