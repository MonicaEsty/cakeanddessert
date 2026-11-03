import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const CakeDessertApp());
}

class CakeDessertApp extends StatelessWidget {
  const CakeDessertApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cake & Dessert Catalog',
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}