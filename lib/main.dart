import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'question_model.dart';
import 'quiz_provider.dart';
import 'quiz_screen.dart';
import 'lessons_screen.dart';

import 'lessons_screen.dart';
import 'lessons_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LessonsProvider()),
        ChangeNotifierProvider(create: (context) => QuizProvider()), // Provide the QuizProvider here
        // Add other providers if needed
      ],
      child: MaterialApp(
        // home: ChangeNotifierProvider(
        //   create: (context) => QuizProvider()..loadQuestions(),
        //   child: QuizScreen(),
        // ),
        home: LessonsScreen(),
      ),
    );
  }
}


class QuestionCard extends StatelessWidget {
  final QuestionModel question;

  QuestionCard({required this.question});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              question.question,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            ...question.options.map((option) => OptionWidget(option: option)).toList(),
          ],
        ),
      ),
    );
  }
}

class OptionWidget extends StatelessWidget {
  final String option;

  OptionWidget({required this.option});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(option),
      onTap: () {
        // Implement your logic to check the selected answer
        // and display feedback to the user
      },
    );
  }
}