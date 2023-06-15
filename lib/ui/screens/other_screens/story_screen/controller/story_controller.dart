import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/models/story_model.dart';
import '../story_timer.dart';

class StoryController extends GetxController with GetSingleTickerProviderStateMixin {
  StoryController({required this.elements, required this.initialPeopleIndex});
  final int initialPeopleIndex;
  final List<StoryModel> elements;

  final scaffoldKey = GlobalKey();
  BuildContext get context => scaffoldKey.currentContext!;
  late final PageController peopleController;

  final RxDouble delta = 0.0.obs;
  final RxInt currentPage = 0.obs;
  final RxDouble indicatorValue = 0.0.obs;

//tap handler for changing stories. if user click left side of the screen, it will go to previous story. if user click right side of the screen, it will go to next story.
  Future<void> tapHandler(TapUpDetails position) async {
    if (position.globalPosition.dx < MediaQuery.of(context).size.width / 2) {
      await _previousStory();
    } else {
      await _nextStory();
    }
  }

//_nextStory function is for changing stories. if user has more stories, it will go to next story. if user has no more stories, it will go to next people.
  Future<void> _nextStory() async {
    StoryTimer.instance.resetTime();
    if (currentPeopleStoryLenght.value - 1 > currentStoryIndex.value) {
      currentStoryIndex.value += 1;
    } else {
      await _nextPeople();
    }
    StoryTimer.instance.resume();
  }

  //_previousStory function is for changing stories. if user has more stories, it will go to previous story. if user has no more stories, it will go to previous people.
  Future<void> _previousStory() async {
    StoryTimer.instance.resetTime();

    if (currentStoryIndex.value > 0) {
      currentStoryIndex.value -= 1;
    } else {
      await _previousPeople();
    }
    StoryTimer.instance.resume();
  }

  Future<void> _nextPeople() async {
    print("next people");
    StoryTimer.instance.resetTime();
    await peopleController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  Future<void> _previousPeople() async {
    print("previous people");
    StoryTimer.instance.resetTime();
    await peopleController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  final RxInt currentPeopleStoryLenght = 0.obs;
  final RxInt currentStoryIndex = 0.obs;

  /// this function for [StoryTimer]. it will bi triggered when timers duration is over.
  Future<void> _storyPeopleControllerListener() async {
    currentPage.value = peopleController.page!.floor();
    delta.value = peopleController.page! - peopleController.page!.floor();
    print(peopleController.page);
    var offset = peopleController.offset;

    if (offset < -100 || offset > peopleController.position.maxScrollExtent + 100) {
      await Navigator.maybePop(context);
    }

    delta.value == 0 && offset >= 0 ? StoryTimer.instance.resume() : StoryTimer.instance.pause();
  }

  void _durationAnimationListener() {
    var initialTime = StoryTimer.instance.initialDuration.inMicroseconds;
    var remainTime = StoryTimer.instance.remainTime!.inMicroseconds;
    var val = (initialTime - remainTime) / initialTime;

    indicatorValue.value = val;
  }

  @override
  void onInit() {
    super.onInit();
    StoryTimer.instance.initialDuration = const Duration(seconds: 5);
    StoryTimer.instance.addListener(_durationAnimationListener, _nextStory);
    peopleController = PageController(initialPage: initialPeopleIndex)..addListener(_storyPeopleControllerListener);
  }

  @override
  void onClose() {
    peopleController.removeListener(_storyPeopleControllerListener);
    peopleController.dispose();
    StoryTimer.instance.dispose();
    super.onClose();
  }
}
