import 'package:flutter/material.dart';

import 'screens/nutritional_lookup_screen.dart';
import 'theme/bustan_theme.dart';

void main() {
  runApp(const NutritionalLookupPreviewApp());
}

class NutritionalLookupPreviewApp extends StatelessWidget {
  const NutritionalLookupPreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutritional Lookup preview',
      debugShowCheckedModeBanner: false,
      theme: BustanTheme.light(),
      home: const NutritionalLookupScreen(),
    );
  }
}
