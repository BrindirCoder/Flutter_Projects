import 'package:flutter/material.dart';
import '../models/question_model.dart';

class QuizHomeScreen extends StatefulWidget {
  const QuizHomeScreen({super.key});

  @override
  State<QuizHomeScreen> createState() => _QuizHomeScreenState();
}

class _QuizHomeScreenState extends State<QuizHomeScreen> {
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;
  bool _isAnswered = false;

  final List<QuestionModel> _questions = [
    QuestionModel(
      question: 'کامیان بۆ دروستکردنی ڕووکار (UI) لە فڵاتەر بەکاردێت؟',
      options: ['Widget', 'Function', 'Database', 'API'],
      correctAnswerIndex: 0,
    ),
    QuestionModel(
      question: 'زمانی سەرەکیی بەرنامەسازی لە Flutter چییە؟',
      options: ['Java', 'Python', 'Dart', 'Kotlin'],
      correctAnswerIndex: 2,
    ),
    QuestionModel(
      question: 'کام کۆمپانیا گەشەی بە فڵاتەر داوە؟',
      options: ['Apple', 'Microsoft', 'Google', 'Meta'],
      correctAnswerIndex: 2,
    ),
  ];

  void _answerQuestion(int index) {
    if (_isAnswered) return;

    setState(() {
      _selectedOptionIndex = index;
      _isAnswered = true;
      if (index == _questions[_currentIndex].correctAnswerIndex) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _currentIndex++;
      _selectedOptionIndex = null;
      _isAnswered = false;
    });
  }

  void _resetQuiz() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _selectedOptionIndex = null;
      _isAnswered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isCompleted = _currentIndex >= _questions.length;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text(
          'یاریی زانیاری و تاقیکردنەوە',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E293B),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: isCompleted ? _buildResultScreen() : _buildQuizContent(),
      ),
    );
  }

  Widget _buildQuizContent() {
    final currentQuestion = _questions[_currentIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'پرسیاری ${_currentIndex + 1} لە ${_questions.length}',
          style: const TextStyle(
            color: Colors.indigoAccent,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            currentQuestion.question,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 30),
        ...List.generate(currentQuestion.options.length, (index) {
          Color buttonColor = const Color(0xFF1E293B);

          if (_isAnswered) {
            if (index == currentQuestion.correctAnswerIndex) {
              buttonColor = Colors.green.shade700;
            } else if (index == _selectedOptionIndex) {
              buttonColor = Colors.red.shade700;
            }
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () => _answerQuestion(index),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  currentQuestion.options[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }),
        const Spacer(),
        if (_isAnswered)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: _nextQuestion,
            child: const Text(
              'پرسیاری دواتر ➔',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildResultScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.emoji_events_rounded, size: 90, color: Colors.amber),
        const SizedBox(height: 20),
        const Text(
          'تاقیکردنەوەکەت تەواو کرد!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'نمرەکەت: $_score لە ${_questions.length}',
          style: const TextStyle(color: Colors.white70, fontSize: 18),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6366F1),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: _resetQuiz,
          child: const Text(
            'دووبارەکردنەوە',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
