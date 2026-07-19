import 'package:flutter/material.dart';
import '../models/video_model.dart';
import '../screens/video_player_screen.dart'; // هێنانی شاشەی ڤیدیۆکە

class VideoCard extends StatelessWidget {
  final VideoModel video;
  const VideoCard({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // کاتێک کلیک لەسەر کارتەکە دەکرێت
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(video: video),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                video.thumbnailUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            video.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            video.subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }
}
