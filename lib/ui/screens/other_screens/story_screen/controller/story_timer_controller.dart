import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum StoryTimerStatus { pause, resume }

///[StoryTimerController] is a singleton class that is used to manage the timer of the story.
///Default timer has no pause and resume functionality. So, we need to create a custom timer.
class StoryTimerController {
  VideoPlayerController? videoPlayerController;
  late Timer timer;

  late VoidCallback _nextListener;

  StoryTimerStatus status = StoryTimerStatus.pause;

  late Duration initialDuration;
  Duration? remainTime;

  /// timer has a 2 listener. One of them is for duration and the other one is for next story.
  void addListener(VoidCallback nextListener) {
    _nextListener = nextListener;
    _setTimer(_nextListener);
    status = StoryTimerStatus.resume;
  }

  /// if story will pause, we need to pause the timer and video player.
  void pause() {
    timer.cancel();
    if (videoPlayerController != null) videoPlayerController!.pause();

    status = StoryTimerStatus.pause;
  }

  /// if story will resume, we need to resume the timer and video player.
  ///we have stored the remain time in the [remainTime] variable. So, we can continue the timer from the last time.
  void resume() {
    if (status == StoryTimerStatus.pause) {
      if (videoPlayerController != null) videoPlayerController!.play();

      _setTimer(_nextListener);
    }
    status = StoryTimerStatus.resume;
  }

  /// if story will reset, we need to reset the timer and video player.
  /// we have stored the initial duration in the [initialDuration] variable. So, we can continue the timer from the last time.
  /// if story time is different from the default time, we need to reset the timer.
  void resetTime() => remainTime = initialDuration;

  void _setTimer(VoidCallback nextListener) {
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      remainTime ??= initialDuration;

      if (remainTime! <= Duration.zero) {
        nextListener.call();
        resetTime();
      }
      remainTime = remainTime! - const Duration(milliseconds: 10);
    });
  }

  void dispose() => timer.cancel();
}
