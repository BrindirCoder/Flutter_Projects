import 'dart:convert';

class TodoModel {
  final String id;
  final String title;
  bool isCompleted;

  TodoModel({required this.id, required this.title, this.isCompleted = false});

  // گۆڕینی داتا بۆ Map تا بتوانین بیکەین بە JSON
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'isCompleted': isCompleted};
  }

  // دروستکردنی مۆدێل لە Mapکەوە
  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source));
}
