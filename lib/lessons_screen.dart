import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'lesson_model.dart';
import 'lessons_provider.dart';
import 'video_player_screen.dart';
import 'quiz_provider.dart';
import 'quiz_screen.dart';

class LessonsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<LessonModel>(
          future: Provider.of<LessonsProvider>(context, listen: false).loadLessons(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...'); // Placeholder text while loading
            } else if (snapshot.hasError) {
              return Text('Error'); // Placeholder text for errors
            } else {
              return Text(snapshot.data!.title); // Display the actual title
            }
          },
        ),
      ),
      body: LessonsList(),
    );
  }
}

class LessonsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lessonsProvider = Provider.of<LessonsProvider>(context);
    final lessonsElements = lessonsProvider.lessonsElements;
    final title = lessonsProvider.lessonsTitle;

    return ListView.builder(
      itemCount: lessonsElements.length,
      itemBuilder: (context, index) {
        return LessonCard(lessonElement: lessonsElements[index]);
      },
    );
  }
}

class LessonCard extends StatelessWidget {
  final LessonElementModel lessonElement;

  LessonCard({required this.lessonElement});

  @override
  Widget build(BuildContext context) {
    print('lessonElement.video: ${lessonElement.video}');
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              lessonElement.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (lessonElement.quiz) ...[
                _buildQuizWidget()
            ] else ...[
                GoButtonWidget(file: lessonElement.file, video: lessonElement.video),
            ]
          ],
        ),
      ),
    );
  }

    Widget _buildQuizWidget() {
    // Assuming you have quiz scores available for each lesson element
    int quizScore = 0; // Replace 0 with the actual quiz score for the lesson element
    return QuizScoreWidget(quizScore: quizScore, file: lessonElement.file);
  }
}

class GoButtonWidget extends StatelessWidget {
  final String file;
  final String? video;

  GoButtonWidget({required this.file, this.video});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (video != null) {
          print('has video $video');
          _playVideo(context, video!);
        } else {
          print('no video: file: $file video: $video');
          _startQuiz(context, file);
        }
      },
      child: Text('Go'),
    );
  }

  void _playVideo(BuildContext context, String videoPath) {
    print('initializing video player');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(
          videoPath: videoPath,
          onVideoComplete: () {
            _startQuiz(context, file);
          },
        ),
      ),
    );
  }

  void _startQuiz(BuildContext context, String file) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    quizProvider.loadQuestions(file).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizScreen(),
        ),
      );
    });
  }
}

class QuizScoreWidget extends StatelessWidget {
  final int quizScore;
  final String file;
  final String? video;

  QuizScoreWidget({required this.quizScore, required this.file, this.video});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StarWidget(filled: quizScore >= 1),
            StarWidget(filled: quizScore >= 2),
            StarWidget(filled: quizScore >= 3),
          ],
        ),
        if (quizScore == 0)
          GoButtonWidget(file: file, video: video), // Replace 'quiz.json' with the actual quiz file
      ],
    );
  }
}

class StarWidget extends StatelessWidget {
  final bool filled;
  StarWidget({required this.filled});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star,
      size: 24,
      color: Colors.grey,
    );
  }
}