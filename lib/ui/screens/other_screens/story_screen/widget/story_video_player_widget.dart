part of '../view/story_view.dart';

class _StoryVideoPlayerWidget extends StatefulWidget {
  const _StoryVideoPlayerWidget({
    required this.storyTimer,
    required this.url,
  });

  final StoryTimerController storyTimer;
  final String url;

  @override
  State<_StoryVideoPlayerWidget> createState() => _StoryVideoPlayerWidgetState();
}

class _StoryVideoPlayerWidgetState extends State<_StoryVideoPlayerWidget> {
  Future<void> init() async {
    widget.storyTimer.videoPlayerController = VideoPlayerController.asset(widget.url);
    await widget.storyTimer.videoPlayerController!.initialize();
    widget.storyTimer.initialDuration = widget.storyTimer.videoPlayerController!.value.duration;
    widget.storyTimer.resetTime();
    // Log.error(widget.storyTimer.videoPlayerController!.value.duration);
    widget.storyTimer.videoPlayerController!.play();
  }

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    widget.storyTimer.initialDuration = const Duration(seconds: 5);
    widget.storyTimer.resetTime();
    if (widget.storyTimer.videoPlayerController != null) widget.storyTimer.videoPlayerController!.dispose();
    widget.storyTimer.videoPlayerController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      color: Colors.transparent,
      child: widget.storyTimer.videoPlayerController != null
          ? AspectRatio(
              aspectRatio: widget.storyTimer.videoPlayerController!.value.aspectRatio,
              child: VideoPlayer(widget.storyTimer.videoPlayerController!),
            )
          : const SizedBox(),
    );
  }
}
