class QuestionModel {
  final String question;
  final List<String> options;
  final String correctAnswer;
  String? selectedAnswer; // Added property to store the selected answer

  QuestionModel({
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.selectedAnswer,
  });
}