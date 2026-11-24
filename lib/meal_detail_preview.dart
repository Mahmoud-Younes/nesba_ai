import 'package:flutter/material.dart';

import 'screens/meal_detail_screen.dart';
import 'theme/bustan_theme.dart';

void main() {
  runApp(const MealDetailPreviewApp());
}

class MealDetailPreviewApp extends StatelessWidget {
  const MealDetailPreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Detail preview',
      debugShowCheckedModeBanner: false,
      theme: BustanTheme.light(),
      home: const MealDetailScreen(),
    );
  }
}
