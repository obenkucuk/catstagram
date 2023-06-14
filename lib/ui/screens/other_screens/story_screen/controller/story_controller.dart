import 'package:catstagram/ui/screens/other_screens/story_screen/controller/story_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/logger.dart';
import '../model/story_page_element_model.dart';

class StoryController extends GetxController {
  final pageKey = GlobalKey<NavigatorState>();

  BuildContext get context => pageKey.currentContext!;

  late final PageController storyController;
  RxDouble delta = 0.0.obs;
  RxInt currentPage = 0.obs;
  late List<StoryPageElements> elements;
  final List<Widget> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ]
      .map((e) => Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: e,
          ))
      .toList();

  Future autoNextPage() async {
    Log.print("autonextpage");

    if (storyController.page!.floor() < elements.length - 1) {
      return storyController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
    } else {
      Navigator.pop(pageKey.currentContext!);
    }

    Log.print("auto2");

    return "";
  }

  _storyControllerListener() {
    currentPage.value = storyController!.page!.floor();
    delta.value = storyController.page! - storyController!.page!.floor();

    if (((elements.length - 1) * MediaQuery.of(context).size.width) < storyController.offset - 50) {
      Navigator.maybePop(pageKey.currentContext!);
    } else if (storyController.offset < -50) {
      Navigator.maybePop(pageKey.currentContext!);
    } else if (delta.value == 0 && storyController.offset >= 0) {
      myTimer.resume();
    } else {
      myTimer.pause();
    }
  }

  _storyTimerListener1() {
    // print(myTimer.remainTime);
  }

  _storyTimerListener2() {
    autoNextPage();
  }

  late StoryTimer myTimer;
  @override
  void onInit() {
    super.onInit();
    elements = [
      StoryPageElements(colors.getRange(0, 2).toList()),
      StoryPageElements(colors.getRange(2, 4).toList()),
      StoryPageElements(colors.getRange(0, 5).toList())
    ];
    myTimer = StoryTimer(1)..addListener(_storyTimerListener1, _storyTimerListener2);

    storyController = PageController()..addListener(_storyControllerListener);
  }

  @override
  void onClose() {
    storyController.removeListener(_storyControllerListener);
    storyController.dispose();
    myTimer.dispose();
    super.onClose();
  }
}
