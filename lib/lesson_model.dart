class LessonModel {
  final String title;
  final List<LessonElementModel> elements;

  LessonModel({required this.title, required this.elements});
}

class LessonElementModel {
  final String name;
  final String file;
  final bool quiz;
  final String? video; // Optional video field

  LessonElementModel({
    required this.name,
    required this.file,
    required this.quiz,
    this.video // Optional video field
  });
}