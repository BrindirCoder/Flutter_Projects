import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // هێنانی شاشەی لۆگین بۆ ئێرە

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure Auth App',
      debugShowCheckedModeBanner:
          false, // لادانی هێمای سووری Debug لە سەرەوەی شاشە
      theme: ThemeData(
        brightness: Brightness.dark, // ناساندنی تیمی تاریک بۆ تەواوی ئەپەکە
      ),
      home: const LoginScreen(), // لێرەوە دیاری دەکەین یەکەم شاشە لۆگین بێت
    );
  }
}
