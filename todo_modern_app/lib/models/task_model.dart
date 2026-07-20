class TaskModel {
  final String id;
  final String title;
  bool isCompleted; // دەگۆڕێت بۆ true ئەگەر کارەکە تەواو بوو

  TaskModel({
    required this.id,
    required this.title,
    this.isCompleted = false, // بە شێوەی بنەڕەتی کارەکان تەواونەکراون
  });
}