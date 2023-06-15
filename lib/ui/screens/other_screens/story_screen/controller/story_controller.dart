import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/models/story_model.dart';
import '../story_timer.dart';

class StoryController extends GetxController with GetSingleTickerProviderStateMixin {
  StoryController({required this.elements, required this.initialPeopleIndex});

  /// Items sent from the home screen.
  final int initialPeopleIndex;
  final List<StoryModel> elements;
  final scaffoldKey = GlobalKey();
  BuildContext get context => scaffoldKey.currentContext!;

  late final PageController peopleController;
  late final StoryTimer storyTimer;

  final RxDouble delta = 0.0.obs;
  final RxInt currentPage = 0.obs;
  final RxDouble indicatorValue = 0.0.obs;

//tap handler for changing stories. if user click left side of the screen, it will go to previous story. if user click right side of the screen, it will go to next story.
  Future<void> tapHandler(TapUpDetails position) async {
    position.globalPosition.dx < MediaQuery.of(context).size.width / 2 ? await _previousStory() : await _nextStory();
  }

//_nextStory function is for changing stories. if user has more stories, it will go to next story. if user has no more stories, it will go to next people.
  Future<void> _nextStory() async {
    storyTimer.resetTime();
    if (elements[currentPage.value].storyList.length - 1 > currentStoryIndex.value) {
      currentStoryIndex.value += 1;
    } else {
      await _nextPeople();
    }
    storyTimer.resume();
  }

  //_previousStory function is for changing stories. if user has more stories, it will go to previous story. if user has no more stories, it will go to previous people.
  Future<void> _previousStory() async {
    storyTimer.resetTime();

    if (currentStoryIndex.value > 0) {
      currentStoryIndex.value -= 1;
    } else {
      await _previousPeople();
    }
    storyTimer.resume();
  }

  Future<void> _nextPeople() async {
    storyTimer.resetTime();
    await peopleController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  Future<void> _previousPeople() async {
    storyTimer.resetTime();
    await peopleController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  final RxInt currentStoryIndex = 0.obs;

  /// this function for [StoryTimer]. it will bi triggered when timers duration is over.
  Future<void> _storyPeopleControllerListener() async {
    currentPage.value = peopleController.page!.floor();
    print(currentPage.value);

    delta.value = peopleController.page! - peopleController.page!.floor();
    var offset = peopleController.offset;

    if (offset < -100 || offset > peopleController.position.maxScrollExtent + 100) {
      await Navigator.maybePop(context);
    }

    delta.value == 0 && offset >= 0 ? storyTimer.resume() : storyTimer.pause();
  }

  Future<void> _durationAnimationListener() async {
    var initialTime = storyTimer.initialDuration.inMicroseconds;
    var remainTime = storyTimer.remainTime!.inMicroseconds;
    var val = (initialTime - remainTime) / initialTime;

    indicatorValue.value = val;
  }

  @override
  void onInit() {
    super.onInit();
    storyTimer = StoryTimer()..addListener(_durationAnimationListener, _nextStory);
    storyTimer.initialDuration = const Duration(seconds: 5);
    peopleController = PageController(initialPage: initialPeopleIndex)..addListener(_storyPeopleControllerListener);
  }

  @override
  void onClose() {
    peopleController.removeListener(_storyPeopleControllerListener);
    peopleController.dispose();
    storyTimer.dispose();
    super.onClose();
  }
}
