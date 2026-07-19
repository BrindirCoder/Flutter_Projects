class VideoModel {
  final String thumbnailUrl;
  final String title;
  final String subtitle;
  final String videoUrl; // ئەمە ئێستا دەبێتە ناونیشانی فۆڵدەرەکە (Asset Path)

  VideoModel({
    required this.thumbnailUrl,
    required this.title,
    required this.subtitle,
    required this.videoUrl,
  });
}

// داتای تاقیکاری بە بەکارهێنانی ڤیدیۆ ناوخۆییەکانت
final List<VideoModel> sampleVideos = [
  VideoModel(
    thumbnailUrl:
        'https://i.pinimg.com/736x/12/ee/c7/12eec7fb293549dcf9031fd06419c8bf.jpg',
    title: ' firsr vedio',
    subtitle: 'Anime',
    videoUrl: 'assets/videos/Anime.mp4', // ناونیشانی فایلی یەکەم کە خۆت داتناوە
  ),
  VideoModel(
    thumbnailUrl:
        'https://i.pinimg.com/1200x/fd/fe/aa/fdfeaa00781e2cc693e9b4e1e96af712.jpg',
    title: ' second vedio',
    subtitle: 'Anime',
    videoUrl: 'assets/videos/frinds.mp4', // ناونیشانی فایلی دووەم
  ),
  VideoModel(
    thumbnailUrl:
        'https://i.pinimg.com/736x/19/66/97/1966972d66b44fbe01f6d78f4ca6d03f.jpg',
    title: ' third vedio',
    subtitle: 'Anime',
    videoUrl: 'assets/videos/itachi.mp4', // ناونیشانی فایلی دووەم
  ),
];
