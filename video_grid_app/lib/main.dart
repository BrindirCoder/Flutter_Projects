import 'package:flutter/material.dart';
import 'screens/home_grid_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Grid App',
      home: const HomeGridScreen(),
    );
  }
}
