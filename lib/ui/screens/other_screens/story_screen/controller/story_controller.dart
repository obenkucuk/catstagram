import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/models/story_model.dart';
import 'story_timer_controller.dart';

enum StoryUpdateKeys { storyScreen }

class StoryController extends GetxController with GetSingleTickerProviderStateMixin {
  StoryController({required this.elements, required this.initialPeopleIndex});

  /// Items sent from the home screen.
  final int initialPeopleIndex;
  final List<StoryModel> elements;
  final scaffoldKey = GlobalKey();
  BuildContext get context => scaffoldKey.currentContext!;

  late final PageController peopleController;
  late final StoryTimerController storyTimer;

  final RxDouble delta = 0.0.obs;
  final RxInt currentPage = 0.obs;
  late final Rx<AnimationController> animationController;
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
      update([StoryUpdateKeys.storyScreen]);
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
      update([StoryUpdateKeys.storyScreen]);
    } else {
      await _previousPeople();
    }
    storyTimer.resume();
  }

  Future<void> _nextPeople() async {
    currentStoryIndex.value = 0;
    update([StoryUpdateKeys.storyScreen]);
    storyTimer.resetTime();
    await peopleController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  Future<void> _previousPeople() async {
    currentStoryIndex.value = 0;
    update([StoryUpdateKeys.storyScreen]);
    storyTimer.resetTime();
    await peopleController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  final RxInt currentStoryIndex = 0.obs;

  /// this function for [StoryTimerController]. it will bi triggered when timers duration is over.
  Future<void> _storyPeopleControllerListener() async {
    delta.value = peopleController.page! - peopleController.page!.floor();
    var offset = peopleController.offset;
    peopleController.position.axisDirection == AxisDirection.right
        ? currentPage.value = peopleController.page!.floor()
        : currentPage.value = peopleController.page!.ceil();

    if (offset < -100 || offset > peopleController.position.maxScrollExtent + 100) {
      await Navigator.maybePop(context);
    }

    delta.value == 0 && offset >= 0 ? storyTimer.resume() : storyTimer.pause();
  }

  @override
  void onInit() {
    super.onInit();
    storyTimer = StoryTimerController()..addListener(_nextStory);
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
