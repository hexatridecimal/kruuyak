import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'question_model.dart';

class QuestionCard extends StatefulWidget {
  final QuestionModel question;
  final VoidCallback onNextQuestion;
  final double progress;

  QuestionCard({
    required this.question,
    required this.onNextQuestion,
    required this.progress,
  });

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String? _selectedAnswer;

  void _onAnswerSelected(String answer) {
    setState(() {
      _selectedAnswer = answer;
      widget.question.selectedAnswer = answer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.question.question,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            ...widget.question.options.map((option) => OptionWidget(
                  option: option,
                  isSelected: option == _selectedAnswer,
                  onSelected: _onAnswerSelected,
                )).toList(),
            SizedBox(height: 20),
            LinearProgressIndicator(value: widget.progress),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _selectedAnswer != null ? widget.onNextQuestion : null,
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class OptionWidget extends StatelessWidget {
  final String option;
  final bool isSelected;
  final Function(String) onSelected;

  OptionWidget({
    required this.option,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(option),
      onTap: () => onSelected(option),
      tileColor: isSelected ? Colors.blue : null,
    );
  }
}