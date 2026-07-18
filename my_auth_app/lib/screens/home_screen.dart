import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'about_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // بەکارهێنانی ڕەنگی تاریکی پشتەوە
      // بەشی سەرەوەی لاپەڕەکە (AppBar)
      appBar: AppBar(
        title: const Text(
          'Home Screen',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.containerFill,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading:
            false, // ناهێڵێت تیرۆکی گەڕانەوە بۆ لۆگین پیشان بدات
      ),

      // بەشی ناوەڕۆکی لاپەڕەکە
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),

            // پیشاندانی وێنەکە وەک داوات کردبوو لەگەڵ خڕکردنی لێوارەکانی
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/home_img.jpg',
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // تێکستەکانی ناو پەرەی هۆم
            const Text(
              'بەخێرهاتی بۆ پەرەی سەرەکی!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'ئەم ئەپە بە شێوازێکی تەواو پرۆفیشناڵ و خاوێن کۆدکراوە. ئێستا دەتوانیت لە ڕێگەی ئایکۆنەکانی خوارەوە بچیتە پەرەی دەربارە (About).',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textGrey,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),

      // تووڵی ئایکۆنەکانی خوارەوە (Bottom Navigation Bar)
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.containerFill,
        selectedItemColor: Colors.white, // ڕەنگی ئایکۆنی چالاک
        unselectedItemColor: AppColors.textGrey, // ڕەنگی ئایکۆنی ناچالاک
        currentIndex: 0, // 0 واتە ئێستا لەسەر هۆمین
        onTap: (index) {
          // ئەگەر کلیک لەسەر ئایکۆنی دووەم کرا (About) کە ئیندێکسەکەی 1ە
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutScreen()),
            );
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
