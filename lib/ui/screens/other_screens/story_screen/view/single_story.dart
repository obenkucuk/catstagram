import 'package:catstagram/core/extensions/to_cats_id_url.dart';
import 'package:catstagram/core/logger.dart';
import 'package:catstagram/ui/screens/other_screens/story_screen/story_timer.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/models/cats_from_tag_response_model.dart';

class SingleStoryBuilder extends StatelessWidget {
  final CatFromTagResponseModel model;
  const SingleStoryBuilder({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    if (model.contentType == ReqContentType.video) {
      return const VideoStoryWidget();
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
  const VideoStoryWidget({super.key});

  @override
  State<VideoStoryWidget> createState() => _VideoStoryWidgetState();
}

class _VideoStoryWidgetState extends State<VideoStoryWidget> {
  Future<void> init() async {
    StoryTimer.instance.videoPlayerController = VideoPlayerController.asset('assets/video.mp4');
    await StoryTimer.instance.videoPlayerController!.initialize();

    StoryTimer.instance.initialDuration = StoryTimer.instance.videoPlayerController!.value.duration;
    StoryTimer.instance.resetTime();

    Log.error(StoryTimer.instance.videoPlayerController!.value.duration);

    StoryTimer.instance.videoPlayerController!.play();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    StoryTimer.instance.initialDuration = const Duration(seconds: 5);
    StoryTimer.instance.resetTime();
    StoryTimer.instance.videoPlayerController!.dispose();
    StoryTimer.instance.videoPlayerController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      color: Colors.transparent,
      child: AspectRatio(
          aspectRatio: StoryTimer.instance.videoPlayerController!.value.aspectRatio,
          child: VideoPlayer(StoryTimer.instance.videoPlayerController!)),
    );
  }
}
