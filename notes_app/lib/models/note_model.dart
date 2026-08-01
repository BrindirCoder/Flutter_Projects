import 'package:flutter/material.dart';

class NoteModel {
  final String id;
  final String title;
  final String content;
  final String category;
  final Color color;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.color,
  });
}