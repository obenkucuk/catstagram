import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../main_screens/home_screen/controller/home_controller.dart';
import '../smooth_story_controller.dart';
import '../story_timer.dart';

class StoryController extends GetxController with GetSingleTickerProviderStateMixin {
  final List<StoryModel> elements;

  static int length = 0;

  StoryController(this.elements);
  late AnimationController durationAnimationController;

  final pageKey = GlobalKey<NavigatorState>();

  late final PageController storyPeopleController;
  late final SmoothPageController storyController;
  RxDouble delta = 0.0.obs;
  RxInt currentPage = 0.obs;
  Duration currentStoryDuration = const Duration(seconds: 5);
  RxDouble indicatorValue = 0.0.obs;

  Future<void> tapHandler(TapUpDetails position, int singleStoryIndex, BuildContext context, int peopleIndex) async {
    if (position.globalPosition.dx < MediaQuery.of(context).size.width / 2) {
      await _previousStory(elements[peopleIndex].storyList.length, singleStoryIndex);
    } else {
      await _nextStory(elements[peopleIndex].storyList.length, singleStoryIndex);
    }

    // print("length" + storyController.length.toString());
    // print("index" + storyController.index.toString());
  }

  Future<void> _nextStory(int length, int? index) async {
//    setNewDuration(Duration(seconds: deneme));
    print("ooooo1");
    StoryTimer.instance.resetTime();
    if (index == null) {
      return storyController.smoothNext();
    }
    if (length - 1 > index) {
      storyController.smoothNext();
    } else {
      await _nextPeople();
    }
    StoryTimer.instance.resume();
  }

  Future<void> _previousStory(int length, int? index) async {
    print("ooooo2");

    StoryTimer.instance.resetTime();
    if (index == null) {
      return storyController.smoothPrevious();
    }
    if (index > 0) {
      storyController.smoothPrevious();
    } else {
      await _previousPeople();
    }
    StoryTimer.instance.resume();
  }

  Future<void> _nextPeople() async {
    print("ooooo3");

    StoryTimer.instance.resetTime();
    await storyPeopleController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  Future<void> _previousPeople() async {
    print("ooooo4");

    StoryTimer.instance.resetTime();
    await storyPeopleController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  _autoNext() async {
    if (storyController.length! - 1 > storyController.index!) {
      _nextStory(length, null);
    } else {
      await _nextPeople();
    }
  }

  _storyPeopleControllerListener() {
    currentPage.value = storyPeopleController!.page!.floor();
    delta.value = storyPeopleController.page! - storyPeopleController!.page!.floor();

    if (delta.value == 0 && storyPeopleController.offset >= 0) {
      StoryTimer.instance.resume();
    } else {
      StoryTimer.instance.pause();
    }
  }

  Duration? lastDuration;
  setNewDuration(Duration duration) {
    if (lastDuration != duration) {
      StoryTimer.instance.initialDuration = duration;
    }
    lastDuration = duration;
  }

  _storyTimerListener1() {
//    print(StoryTimer.instance.remainTime);
//    currentStoryDuration.value = StoryTimer.instance.remainTime!;
    _durationToAnimation();
  }

  _durationToAnimation() {
    int max = StoryTimer.instance.initialDuration.inMilliseconds;
    durationAnimationController.animateTo(StoryTimer.instance.remainTime!.inMilliseconds / max,
        duration: durationAnimationController.value != 1 ? const Duration(milliseconds: 100) : const Duration());
  }

  _storyTimerListener2() {
    _autoNext();
  }

  _durationAnimationListener() {
    // print(indicatorValue.value);
    if (durationAnimationController.value != 1) {
      indicatorValue.value = 1 - durationAnimationController.value;
    } else {
      indicatorValue.value = 0;
    }
  }

  @override
  void onInit() {
    super.onInit();
    durationAnimationController = AnimationController(vsync: this)..addListener(_durationAnimationListener);

    StoryTimer.instance.initialDuration = const Duration(seconds: 5);
    StoryTimer.instance.addListener(_storyTimerListener1, _storyTimerListener2);

    storyPeopleController = PageController()..addListener(_storyPeopleControllerListener);
    storyController = SmoothPageController();
  }

  @override
  void onClose() {
    durationAnimationController.removeListener(_durationAnimationListener);
    durationAnimationController.dispose();
    storyPeopleController.removeListener(_storyPeopleControllerListener);
    storyPeopleController.dispose();
    storyController.dispose();
    StoryTimer.instance.dispose();
    super.onClose();
  }
}
