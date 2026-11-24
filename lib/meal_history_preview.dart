import 'package:flutter/material.dart';

import 'screens/meal_history_screen.dart';
import 'theme/bustan_theme.dart';

void main() {
  runApp(const MealHistoryPreviewApp());
}

class MealHistoryPreviewApp extends StatelessWidget {
  const MealHistoryPreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal History preview',
      debugShowCheckedModeBanner: false,
      theme: BustanTheme.light(),
      home: const MealHistoryScreen(),
    );
  }
}
