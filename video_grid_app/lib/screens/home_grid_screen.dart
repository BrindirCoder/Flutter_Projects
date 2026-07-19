import 'package:flutter/material.dart';
import '../models/video_model.dart';
import '../widgets/video_card.dart';

class HomeGridScreen extends StatelessWidget {
  const HomeGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // ڕەنگی تاریکی مۆدێرن (Slate)

      appBar: AppBar(
        title: const Text(
          'ڤیدیۆکان',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1E293B),
        centerTitle: true,
        elevation: 0,
      ),

      // بەکارهێنانی GridView.builder بۆ پیشاندانی ڕیزەکان
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: sampleVideos.length, // ژمارەی ڤیدیۆکان
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // دیاریکردنی ٢ ڤیدیۆ لە هەر ڕێزێکدا
            crossAxisSpacing: 12, // بۆشایی نێوان دوو ڤیدیۆکە بە ئاسۆیی
            mainAxisSpacing: 16, // بۆشایی نێوان ڕیزەکان بە ستوونی
            childAspectRatio:
                0.85, // ڕێژەی پانی بۆ بەرزی کارتەکە (کۆنتڕۆڵی قەبارە دەکات)
          ),
          itemBuilder: (context, index) {
            // ناردنی داتای هەر ڤیدیۆیەک بۆ کارتی تایبەت بە خۆی
            return VideoCard(video: sampleVideos[index]);
          },
        ),
      ),
    );
  }
}
