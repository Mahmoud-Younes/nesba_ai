import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'theme/bustan_theme.dart';

void main() => runApp(const DietApp());

class DietApp extends StatelessWidget {
  const DietApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diet companion',
      debugShowCheckedModeBanner: false,
      theme: BustanTheme.light(),
      home: const LoginScreen(),
    );
  }
}
