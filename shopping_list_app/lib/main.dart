import 'package:flutter/material.dart';
import 'package:shopping_list_app/screens/shopping_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping List App',
      home: const ShoppingHomeScreen(),
    );
  }
}