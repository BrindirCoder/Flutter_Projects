import 'package:flutter/material.dart';

// جۆری مامەڵەکە (خەرجی یان داھات)
enum ExpenseType { income, expense }

class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final IconData icon;
  final ExpenseType type;

  ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.icon,
    required this.type,
  });
}
