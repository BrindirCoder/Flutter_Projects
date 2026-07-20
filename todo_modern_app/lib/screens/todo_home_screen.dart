import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../widgets/task_tile.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  final List<TaskModel> _tasks = []; // لیستی کارەکان
  final TextEditingController _controller =
      TextEditingController(); // بۆ وەرگرتنی دەق لە کیبۆردەوە

  void _addTask() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        _tasks.add(
          TaskModel(
            id: DateTime.now().toString(),
            title: _controller.text.trim(),
          ),
        );
      });
      _controller.clear(); // پاککردنەوەی ناو چۆنەکە دوای زیادکردن
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // باگراوندی تاریکی مۆدێرن
      appBar: AppBar(
        title: const Text(
          'ڕێکخەری کارەکان',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1E293B),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // بەشی نووسینی کاری نوێ
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'کاری نوێ لێرە بنووسە...',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      fillColor: const Color(0xFF1E293B),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _addTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // لیستی کارەکان
            Expanded(
              child: _tasks.isEmpty
                  ? Center(
                      child: Text(
                        'هیچ کارێک نییە، دەست پێ بکە!',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        final task = _tasks[index];
                        return TaskTile(
                          task: task,
                          onCheckboxChanged: (value) {
                            setState(() {
                              task.isCompleted = value ?? false;
                            });
                          },
                          onDelete: () {
                            setState(() {
                              _tasks.removeAt(index);
                            });
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
