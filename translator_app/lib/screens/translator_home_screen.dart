import 'package:flutter/material.dart';

class TranslatorHomeScreen extends StatefulWidget {
  const TranslatorHomeScreen({super.key});

  @override
  State<TranslatorHomeScreen> createState() => _TranslatorHomeScreenState();
}

class _TranslatorHomeScreenState extends State<TranslatorHomeScreen> {
  String _fromLanguage = 'ڕووسی (Русский)';
  String _toLanguage = 'کوردی (Kurdish)';
  final TextEditingController _inputController = TextEditingController();
  String _translatedText = '';

  // فەرهەنگێکی سادە بۆ تاقیکردنەوە (Mock Data)
  final Map<String, String> _dictionary = {
    'привет': 'سڵاو',
    'спасибо': 'سوپاس',
    'как дела': 'چۆنیت',
    'хорошо': 'باشم',
    'до свидания': 'خوات لەگەڵ',
    'hello': 'سڵاو',
    'thank you': 'سوپاس',
    'how are you': 'چۆنیت',
  };

  void _translate() {
    final query = _inputController.text.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _translatedText = '';
      } else if (_dictionary.containsKey(query)) {
        _translatedText = _dictionary[query]!;
      } else {
        _translatedText = 'وەرگێڕان بۆ "$query" نەدۆزرایەوە (نموونەیی)';
      }
    });
  }

  void _swapLanguages() {
    setState(() {
      final temp = _fromLanguage;
      _fromLanguage = _toLanguage;
      _toLanguage = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('وەرگێڕی خێرا', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E293B),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // بەشی هەڵبژاردنی زمانەکان
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_fromLanguage, style: const TextStyle(color: Colors.indigoAccent, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.swap_horiz_rounded, color: Colors.white),
                      onPressed: _swapLanguages,
                    ),
                    Text(_toLanguage, style: const TextStyle(color: Colors.indigoAccent, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // چوونەژوورەوەی دەق
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _inputController,
                      maxLines: 4,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      decoration: const InputDecoration(
                        hintText: 'وشە یان ڕستە بنووسە... (تیرپپەڕین: привет, спасибо)',
                        hintStyle: TextStyle(color: Colors.white38, fontSize: 14),
                        border: InputBorder.none,
                      ),
                      onChanged: (_) => _translate(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (_inputController.text.isNotEmpty)
                          IconButton(
                            icon: const Icon(Icons.clear, color: Colors.white54),
                            onPressed: () {
                              _inputController.clear();
                              _translate();
                            },
                          ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // بەشی ئەنجامی وەرگێڕان
              if (_translatedText.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('وەرگێڕان:', style: TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 8),
                      Text(
                        _translatedText,
                        style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}