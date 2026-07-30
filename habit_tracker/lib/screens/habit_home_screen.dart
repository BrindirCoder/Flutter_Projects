import 'package:flutter/material.dart';
import '../models/habit_model.dart';

class HabitHomeScreen extends StatefulWidget {
  const HabitHomeScreen({super.key});

  @override
  State<HabitHomeScreen> createState() => _HabitHomeScreenState();
}

class _HabitHomeScreenState extends State<HabitHomeScreen> {
  final List<HabitModel> _habits = [
    HabitModel(
      id: '1',
      title: 'وەرزشی ڕۆژانە',
      icon: Icons.fitness_center,
      color: Colors.orangeAccent,
      streak: 5,
    ),
    HabitModel(
      id: '2',
      title: 'خواردنەوەی ٢ لیتر ئاو',
      icon: Icons.water_drop,
      color: Colors.blueAccent,
      streak: 12,
    ),
    HabitModel(
      id: '3',
      title: 'خوێندنەوەی پەڕتووک (20 خولەک)',
      icon: Icons.menu_book,
      color: Colors.purpleAccent,
      streak: 3,
    ),
    HabitModel(
      id: '4',
      title: 'ڕاهێنانی زمان',
      icon: Icons.language,
      color: Colors.greenAccent,
      streak: 8,
    ),
  ];

  final TextEditingController _titleController = TextEditingController();

  void _toggleHabit(HabitModel habit) {
    setState(() {
      habit.isCompleted = !habit.isCompleted;
      if (habit.isCompleted) {
        habit.streak += 1;
      } else {
        habit.streak -= 1;
      }
    });
  }

  void _addHabit() {
    if (_titleController.text.trim().isEmpty) return;

    setState(() {
      _habits.add(
        HabitModel(
          id: DateTime.now().toString(),
          title: _titleController.text.trim(),
          icon: Icons.star_rounded,
          color: Colors.pinkAccent,
        ),
      );
      _titleController.clear();
    });
    Navigator.pop(context);
  }

  void _showAddHabitDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E293B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'زیادکردنی عادەت یان ڕاهێنانی نوێ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'ناوی ئامانجەکە بنووسە...',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: const Color(0xFF0F172A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: _addHabit,
              child: const Text(
                'زیادکردن',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double get _completionProgress {
    if (_habits.isEmpty) return 0.0;
    int completedCount = _habits.where((h) => h.isCompleted).length;
    return completedCount / _habits.length;
  }

  @override
  Widget build(BuildContext context) {
    int completedCount = _habits.where((h) => h.isCompleted).length;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text(
          'شوێنکەوتنی عادەتەکان',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E293B),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header Card with Progress Indicator
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'پێشکەوتنی ئەمڕۆ',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$completedCount لە ${_habits.length} ئامانج',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        value: _completionProgress,
                        strokeWidth: 6,
                        backgroundColor: Colors.white10,
                        color: const Color(0xFF6366F1),
                      ),
                    ),
                    Text(
                      '${(_completionProgress * 100).toInt()}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Habit List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _habits.length,
              itemBuilder: (context, index) {
                final habit = _habits[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: habit.isCompleted
                          ? habit.color.withOpacity(0.5)
                          : Colors.transparent,
                    ),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: habit.color.withOpacity(0.2),
                      child: Icon(habit.icon, color: habit.color),
                    ),
                    title: Text(
                      habit.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        decoration: habit.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: Text(
                      '🔥 ${habit.streak} ڕۆژ بەردەوامە',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                    trailing: Checkbox(
                      value: habit.isCompleted,
                      activeColor: habit.color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      onChanged: (_) => _toggleHabit(habit),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6366F1),
        onPressed: _showAddHabitDialog,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
