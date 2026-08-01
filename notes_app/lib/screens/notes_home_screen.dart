import 'package:flutter/material.dart';
import '../models/note_model.dart';

class NotesHomeScreen extends StatefulWidget {
  const NotesHomeScreen({super.key});

  @override
  State<NotesHomeScreen> createState() => _NotesHomeScreenState();
}

class _NotesHomeScreenState extends State<NotesHomeScreen> {
  final List<NoteModel> _notes = [
    NoteModel(
      id: '1',
      title: 'خوێندنەوەی کورسی فڵاتەر',
      content:
          'دەبێت ئەمڕۆ ڕاهێنان لەسەر State Management بەباکارهێنانی Riverpod بکەم.',
      category: 'خوێندن',
      color: const Color(0xFF818CF8),
    ),
    NoteModel(
      id: '2',
      title: 'کڕینی کەلوپەل',
      content: 'سێو، شیر، نان، و قاوە لە مارکێت دروست کڕدرێن.',
      category: 'کەسی',
      color: const Color(0xFFF472B6),
    ),
  ];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String _selectedCategory = 'کەسی';

  void _addNote() {
    if (_titleController.text.trim().isEmpty ||
        _contentController.text.trim().isEmpty)
      return;

    Color noteColor = const Color(0xFF818CF8);
    if (_selectedCategory == 'کار') noteColor = const Color(0xFFFBBF24);
    if (_selectedCategory == 'خوێندن') noteColor = const Color(0xFF34D399);
    if (_selectedCategory == 'کەسی') noteColor = const Color(0xFFF472B6);

    setState(() {
      _notes.add(
        NoteModel(
          id: DateTime.now().toString(),
          title: _titleController.text.trim(),
          content: _contentController.text.trim(),
          category: _selectedCategory,
          color: noteColor,
        ),
      );
      _titleController.clear();
      _contentController.clear();
    });
    Navigator.pop(context);
  }

  void _deleteNote(String id) {
    setState(() {
      _notes.removeWhere((note) => note.id == id);
    });
  }

  void _showAddNoteDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E293B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
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
                'تێبینییەکی نوێ بنووسە',
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
                  hintText: 'سەردێڕی تێبینی...',
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xFF0F172A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _contentController,
                maxLines: 3,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'ناوەڕۆکی تێبینییەکە...',
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xFF0F172A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['کەسی', 'خوێندن', 'کار'].map((cat) {
                  final isSelected = _selectedCategory == cat;
                  return ChoiceChip(
                    label: Text(
                      cat,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: const Color(0xFF6366F1),
                    backgroundColor: const Color(0xFF0F172A),
                    onSelected: (selected) {
                      if (selected) {
                        setModalState(() {
                          _selectedCategory = cat;
                        });
                      }
                    },
                  );
                }).toList(),
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
                onPressed: _addNote,
                child: const Text(
                  'پاشەکەوتکردن',
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text(
          'تێبینییەکانم',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E293B),
        centerTitle: true,
        elevation: 0,
      ),
      body: _notes.isEmpty
          ? const Center(
              child: Text(
                'هیچ تێبینییەک نەنوسراوە!',
                style: TextStyle(color: Colors.white54),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(16),
                    border: Border(
                      right: BorderSide(color: note.color, width: 6),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            note.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.redAccent,
                            ),
                            onPressed: () => _deleteNote(note.id),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        note.content,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: note.color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          note.category,
                          style: TextStyle(
                            color: note.color,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6366F1),
        onPressed: _showAddNoteDialog,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
