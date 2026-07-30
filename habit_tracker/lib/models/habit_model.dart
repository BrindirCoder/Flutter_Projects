import 'package:flutter/material.dart';

class HabitModel {
  final String id;
  final String title;
  final IconData icon;
  final Color color;
  bool isCompleted;
  int streak;

  HabitModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    this.isCompleted = false,
    this.streak = 0,
  });
}