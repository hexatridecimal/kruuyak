import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'lesson_model.dart';

class LessonsProvider with ChangeNotifier {
  List<LessonElementModel> _lessonsElements = [];
  String _lessonsTitle = '';

  List<LessonElementModel> get lessonsElements => _lessonsElements;
  String get lessonsTitle => _lessonsTitle;

  Future<LessonModel> loadLessons() async {
    try {
      String jsonString = await rootBundle.loadString('assets/lessons_data.json');
      Map<String, dynamic> jsonData = jsonDecode(jsonString);
      _lessonsTitle = jsonData['title'];
      _lessonsElements = (jsonData['elements'] as List<dynamic>)
          .map((element) => LessonElementModel(
                name: element['name'],
                file: element['file'],
                quiz: element['quiz'],
                video: element['video'],
              ))
          .toList();
      notifyListeners();
      return LessonModel(title: _lessonsTitle, elements: _lessonsElements);
    } catch (e) {
      // Handle the error, such as showing a default set of lessons or an error message
      throw e; // Rethrow the error for the FutureBuilder to handle
    }
  }
}