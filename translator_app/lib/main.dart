import 'package:flutter/material.dart';
import 'screens/translator_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quick Translator App',
      home: const TranslatorHomeScreen(),
    );
  }
}
