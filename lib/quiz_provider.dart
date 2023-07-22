
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'question_model.dart';


class QuizProvider with ChangeNotifier {
  List<QuestionModel> _questions = [];

  List<QuestionModel> get questions => _questions;

  void setAnswer(int questionIndex, String selectedAnswer) {
    _questions[questionIndex].selectedAnswer = selectedAnswer;
    notifyListeners();
  }

  void resetQuiz() {
    for (var question in _questions) {
      question.selectedAnswer = null;
    }
    notifyListeners();
  }

  Future<void> loadQuestions(String filePath) async {
    try {
      String jsonString = await rootBundle.loadString(filePath);
      List<dynamic> jsonMap = jsonDecode(jsonString);
      _questions = jsonMap
          .map((json) => QuestionModel(
                question: json['question'],
                options: List<String>.from(json['options']),
                correctAnswer: json['correctAnswer'],
              ))
          .toList();
      notifyListeners(); // Notify listeners that the data has been loaded
    } catch (e) {
      print('Error loading questions: $e');
    }
  }
}