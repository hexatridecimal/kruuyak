import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'quiz_provider.dart';

class FinalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final questions = quizProvider.questions;
    int correctAnswers = 0;

    // Calculate the total score
    for (var question in questions) {
      if (question.correctAnswer == question.selectedAnswer) {
        correctAnswers++;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App - Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '$correctAnswers / ${questions.length}',
              style: TextStyle(fontSize: 36, color: Colors.green),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Reset the quiz and go back to the first question
                quizProvider.resetQuiz();
                Navigator.pop(context);
              },
              child: Text('Retry Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}