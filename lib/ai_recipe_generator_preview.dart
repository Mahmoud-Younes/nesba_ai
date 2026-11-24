import 'package:flutter/material.dart';

import 'screens/ai_recipe_generator_screen.dart';
import 'theme/bustan_theme.dart';

void main() {
  runApp(const AIRecipeGeneratorPreviewApp());
}

class AIRecipeGeneratorPreviewApp extends StatelessWidget {
  const AIRecipeGeneratorPreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alternative recipe preview',
      debugShowCheckedModeBanner: false,
      theme: BustanTheme.light(),
      home: const AIRecipeGeneratorScreen(
        originalMealDescription:
            'Grilled chicken with brown rice and roasted vegetables',
        preferenceContext: ['Vegetarian', 'Dairy ingredients'],
        isSampleContext: true,
      ),
    );
  }
}
