import 'package:catstagram/core/extensions/to_cats_id_url.dart';
import 'package:catstagram/core/logger.dart';
import 'package:catstagram/ui/screens/other_screens/story_screen/story_timer.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/models/cats_from_tag_response_model.dart';

class SingleStoryBuilder extends StatelessWidget {
  final StoryTimer storyTimer;
  final CatFromTagResponseModel model;
  const SingleStoryBuilder({
    super.key,
    required this.model,
    required this.storyTimer,
  });

  @override
  Widget build(BuildContext context) {
    if (model.contentType == ReqContentType.video) {
      return VideoStoryWidget(storyTimer: storyTimer);
    } else {
      return Image.network(
        model.id!.toCatsIdUrl,
        width: double.maxFinite,
        height: double.maxFinite,
        fit: BoxFit.contain,
      );
    }
  }
}

class VideoStoryWidget extends StatefulWidget {
  final StoryTimer storyTimer;

  const VideoStoryWidget({super.key, required this.storyTimer});

  @override
  State<VideoStoryWidget> createState() => _VideoStoryWidgetState();
}

class _VideoStoryWidgetState extends State<VideoStoryWidget> {
  Future<void> init() async {
    widget.storyTimer.videoPlayerController = VideoPlayerController.asset('assets/video.mp4');
    await widget.storyTimer.videoPlayerController!.initialize();
    widget.storyTimer.initialDuration = widget.storyTimer.videoPlayerController!.value.duration;
    widget.storyTimer.resetTime();
    Log.error(widget.storyTimer.videoPlayerController!.value.duration);
    widget.storyTimer.videoPlayerController!.play();
  }

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    print('Video player gg');
    widget.storyTimer.initialDuration = const Duration(seconds: 5);
    widget.storyTimer.resetTime();
    widget.storyTimer.videoPlayerController!.dispose();
    widget.storyTimer.videoPlayerController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      color: Colors.transparent,
      child: AspectRatio(
          aspectRatio: widget.storyTimer.videoPlayerController!.value.aspectRatio,
          child: VideoPlayer(widget.storyTimer.videoPlayerController!)),
    );
  }
}
