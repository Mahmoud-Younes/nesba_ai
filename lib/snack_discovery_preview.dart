import 'package:flutter/material.dart';

import 'screens/snack_discovery_screen.dart';
import 'theme/bustan_theme.dart';

void main() {
  runApp(const SnackDiscoveryPreviewApp());
}

class SnackDiscoveryPreviewApp extends StatelessWidget {
  const SnackDiscoveryPreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snack Discovery preview',
      debugShowCheckedModeBanner: false,
      theme: BustanTheme.light(),
      home: const SnackDiscoveryScreen(
        preferenceContext: ['Example preference context'],
        isSamplePreview: true,
      ),
    );
  }
}
