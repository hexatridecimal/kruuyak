import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoPath;
  final VoidCallback onVideoComplete;

  VideoPlayerScreen({required this.videoPath, required this.onVideoComplete});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }



  void _initializeVideoPlayer() async {
    _controller = VideoPlayerController.network(widget.videoPath);
    try {
      await _controller.initialize();
    } catch (error) {
      print('Error initializing video player: $error');
    }
    setState(() {});
    if (_controller.value.isInitialized) {
      _controller.play();
      _controller.addListener(_onVideoPlayComplete);
    }
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVideoPlayComplete() {
    widget.onVideoComplete(); // Call the callback when the video playback is complete
    Navigator.pop(context); // Pop the VideoPlayerScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _controller.value.isInitialized
          ? Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            )
          : CircularProgressIndicator(),
    );
  }
}