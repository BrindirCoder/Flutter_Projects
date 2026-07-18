import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // ڕەنگی تاریکی پشتەوە

      appBar: AppBar(
        title: const Text(
          'About Screen',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.containerFill,
        elevation: 0,
        centerTitle: true,
        // گۆڕینی ڕەنگی تیرۆکی سەرەوە بۆ سپی بۆ ئەوەی لەگەڵ ستایلەکە بگونجێت
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // ناوەڕۆکی لاپەڕەکە: تێکستێکی سادە لە ناوەڕاستدا وەک داوات کردبوو
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'ئەمە پەرەی ئەباوتە (About Screen).\nلێرەدا تەنها تێکستێکی سادە و ڕوون پیشانی بەکارهێنەر دەدرێت دەربارەی ئەپەکە.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 18, height: 1.6),
          ),
        ),
      ),

      // تووڵی ئایکۆنەکانی خوارەوە
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.containerFill,
        selectedItemColor: Colors.white,
        unselectedItemColor: AppColors.textGrey,
        currentIndex:
            1, // 1 واتە ئێستا ئایکۆنی About داگیرساوە چونکە لەم لاپەڕەیەین
        onTap: (index) {
          // ئەگەر بەکارهێنەر کلیکی لەسەر ئایکۆنی هۆم کرد (کە ئیندێکسەکەی 0ە)
          if (index == 0) {
            Navigator.pop(
              context,
            ); // لاپەڕەی ئەباوت دادەخات و دەگەڕێتەوە بۆ هۆم
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
        ],
      ),
    );
  }
}
