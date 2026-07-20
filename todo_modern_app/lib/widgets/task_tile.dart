import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final Function(bool?) onCheckboxChanged;
  final VoidCallback onDelete;

  const TaskTile({
    super.key,
    required this.task,
    required this.onCheckboxChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B), // ڕەنگی کارتی مۆدێرن
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: onCheckboxChanged,
          activeColor: const Color(0xFF6366F1), // ڕەنگی مۆدێرنی ئیندیگۆ
        ),
        title: Text(
          task.title,
          style: TextStyle(
            color: task.isCompleted ? Colors.grey : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : null, // هێڵ بەسەر دەقەکەدا دەهێنێت ئەگەر تەواو بوو
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
