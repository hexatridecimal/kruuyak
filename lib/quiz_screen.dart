import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'quiz_provider.dart';
import 'question_card.dart';
import 'final_screen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final questions = quizProvider.questions;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: _currentQuestionIndex < questions.length
          ? QuestionCard(
              question: questions[_currentQuestionIndex],
              onNextQuestion: _nextQuestion,
              progress: (_currentQuestionIndex + 1) / questions.length,
            )
          : FinalScreen(),
    );
  }
}
