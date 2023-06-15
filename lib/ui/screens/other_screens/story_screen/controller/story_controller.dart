import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/models/story_model.dart';
import '../smooth_page_controller.dart';
import '../story_timer.dart';

class StoryController extends GetxController with GetSingleTickerProviderStateMixin {
  final int initialPageIndex;
  final List<StoryModel> elements;
  StoryController(this.elements, this.initialPageIndex);

  static int length = 0;

  final scaffoldKey = GlobalKey();
  BuildContext get context => scaffoldKey.currentContext!;

  late final PageController peopleController;
  late final SmoothPageController storyController;
  RxDouble delta = 0.0.obs;
  RxInt currentPage = 0.obs;
  final Duration currentStoryDuration = const Duration(seconds: 5);
  final RxDouble indicatorValue = 0.0.obs;

//tap handler for changing stories. if user click left side of the screen, it will go to previous story. if user click right side of the screen, it will go to next story.
  Future<void> tapHandler(TapUpDetails position, int singleStoryIndex, int peopleIndex) async {
    if (position.globalPosition.dx < MediaQuery.of(context).size.width / 2) {
      await _previousStory(elements[peopleIndex].storyList.length, singleStoryIndex);
    } else {
      await _nextStory(elements[peopleIndex].storyList.length, singleStoryIndex);
    }
  }

//_nextStory function is for changing stories. if user has more stories, it will go to next story. if user has no more stories, it will go to next people.
  Future<void> _nextStory(int length, int? index) async {
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

//_previousStory function is for changing stories. if user has more stories, it will go to previous story. if user has no more stories, it will go to previous people.
  Future<void> _previousStory(int length, int? index) async {
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
    StoryTimer.instance.resetTime();

    await peopleController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  Future<void> _previousPeople() async {
    print("previous people");

    StoryTimer.instance.resetTime();

    await peopleController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

//this function for [StoryTimer]. it will bi triggered when timers duration is over.
  _autoNextStory() async {
    if (storyController.length - 1 > storyController.index!) {
      _nextStory(length, null);
    } else {
      await _nextPeople();
    }
  }

  _storyPeopleControllerListener() {
    currentPage.value = peopleController.page!.floor();
    delta.value = peopleController.page! - peopleController.page!.floor();
    var offset = peopleController.offset;

    if (offset < -100 || offset > peopleController.position.maxScrollExtent + 100) {
      Navigator.maybePop(context);
    }

    delta.value == 0 && offset >= 0 ? StoryTimer.instance.resume() : StoryTimer.instance.pause();
  }

  _durationAnimationListener() {
    var initialTime = StoryTimer.instance.initialDuration.inMicroseconds;
    var remainTime = StoryTimer.instance.remainTime!.inMicroseconds;
    var val = (initialTime - remainTime) / initialTime;
    indicatorValue.value = val;
  }

  @override
  void onInit() {
    super.onInit();
    StoryTimer.instance.initialDuration = const Duration(seconds: 5);
    StoryTimer.instance.addListener(_durationAnimationListener, _autoNextStory);
    peopleController = PageController(initialPage: initialPageIndex)..addListener(_storyPeopleControllerListener);
    storyController = SmoothPageController(length: elements[initialPageIndex].storyList.length);
  }

  @override
  void onClose() {
    peopleController.removeListener(_storyPeopleControllerListener);
    peopleController.dispose();
    storyController.dispose();
    StoryTimer.instance.dispose();
    super.onClose();
  }
}
