import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../models/video_model.dart';

class VideoPlayerScreen extends StatefulWidget {
  final VideoModel video;
  const VideoPlayerScreen({super.key, required this.video});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    // 🔥 گۆڕانکاری سەرەکی لێرەدایە: بەکارهێنانی .asset لە جیاتی .networkUrl
    _controller = VideoPlayerController.asset(widget.video.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
          _controller.play(); // ڤیدیۆکە یەکسەر لێدەدات دوای لۆدبوون
        });
      });
  }

  @override
  void dispose() {
    _controller
        .dispose(); // داخستنی کۆنتڕۆڵەر بۆ ئەوەی میمۆری مۆبایلەکە پڕ نەبێت
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.video.title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Center(
        child: _isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    VideoPlayer(_controller),
                    VideoProgressIndicator(_controller, allowScrubbing: true),
                    Center(
                      child: IconButton(
                        icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_filled,
                          size: 64,
                          color: Colors.white.withOpacity(0.7),
                        ),
                        onPressed: () {
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )
            : const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
