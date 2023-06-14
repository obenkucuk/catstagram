import 'dart:async';

import 'package:flutter/material.dart';

enum StoryTimerStatus { pause, resume }

class StoryTimer {
  late Timer timer;
  late VoidCallback _listener;
  late VoidCallback _listener2;
  StoryTimerStatus status = StoryTimerStatus.pause;

  final int elementCount;

  Duration remainTime = const Duration(seconds: 5);

  StoryTimer(this.elementCount);

  void addListener(VoidCallback listener, VoidCallback listener2) {
    _listener = listener;
    _listener2 = listener2;
    _setTimer(_listener, _listener2);
    status = StoryTimerStatus.resume;
  }

  pause() {
    timer.cancel();
    status = StoryTimerStatus.pause;
  }

  resume() {
    if (status == StoryTimerStatus.pause) {
      _setTimer(_listener, _listener2);
    }
    status = StoryTimerStatus.resume;
  }

  resetTime() {
    remainTime = const Duration(seconds: 5) * elementCount;
  }

  _setTimer(VoidCallback listener, VoidCallback listener2) {
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (remainTime <= Duration.zero) {
        listener2.call();
        resetTime();
      }
      remainTime = remainTime - const Duration(milliseconds: 100);
      listener.call();
    });
  }

  void dispose() {
    timer.cancel();
  }
}
