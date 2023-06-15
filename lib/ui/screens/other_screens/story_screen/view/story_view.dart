import 'dart:ui';

import 'package:catstagram/constants/hero_tags.dart';
import 'package:catstagram/theme/text_styles.dart';
import 'package:catstagram/ui/screens/other_screens/story_screen/view/single_story.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../../../components/story_transform/cube_transform.dart';
import '../../story_screen/controller/story_controller.dart';
import '../story_timer.dart';

class StoryView extends GetView<StoryController> {
  const StoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        key: controller.scaffoldKey,
        body: Hero(
          tag: HeroTags.story,
          child: GestureDetector(
            onVerticalDragStart: (_) => StoryTimer.instance.pause(),
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity! > 100) Navigator.pop(context);
              StoryTimer.instance.resume();
            },
            //first page view is for people
            child: PageView.builder(
              onPageChanged: (_) => StoryTimer.instance.resetTime(),
              // physics: const BouncingScrollPhysics(),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              controller: controller.peopleController,
              itemCount: controller.elements.length,
              scrollBehavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false,
                overscroll: false,
                dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
              ),
              itemBuilder: (context, peopleIndex) {
                controller.currentPeopleStoryLenght.value = controller.elements[peopleIndex].storyList.length;
                controller.currentStoryIndex.value = 0;
                controller.indicatorValue.value = 0;

                return Obx(
                  () {
                    return ColoredBox(
                      color: Colors.black,
                      child: CubeTransformWidget(
                        index: peopleIndex,
                        pageDelta: controller.delta.value,
                        itemCount: controller.currentPeopleStoryLenght.value,
                        currentPage: controller.currentPage.value,
                        child: SafeArea(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            child: GestureDetector(
                              onLongPressDown: (details) => StoryTimer.instance.pause(),
                              onLongPressEnd: (details) => StoryTimer.instance.resume(),
                              onTapDown: (details) => StoryTimer.instance.pause(),
                              onTapUp: (position) => controller.tapHandler(position),
                              child: ColoredBox(
                                color: Colors.grey,
                                child: Stack(
                                  children: [
                                    SingleStoryBuilder(
                                      model: controller
                                          .elements[peopleIndex].storyList[controller.currentStoryIndex.value],
                                    ),
                                    //indicator
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                                          child: Row(
                                            children: List.generate(
                                              controller.currentPeopleStoryLenght.value,
                                              (indicatorIndex) {
                                                return Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 2, left: 2),
                                                    child: _LinearProgressIndicator(
                                                        value: indicatorIndex == controller.currentStoryIndex.value
                                                            ? controller.indicatorValue.value
                                                            : indicatorIndex >= controller.currentStoryIndex.value
                                                                ? 0
                                                                : 1),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        _StoryUserAreaWidget(
                                          username: controller.elements[peopleIndex].name,
                                          image: controller.elements[peopleIndex].image,
                                          onCloseTap: () => Navigator.pop(context),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _LinearProgressIndicator extends StatelessWidget {
  const _LinearProgressIndicator({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: LinearProgressIndicator(
          value: value,
        ),
      ),
    );
  }
}

class _StoryUserAreaWidget extends StatelessWidget {
  const _StoryUserAreaWidget({
    this.username,
    required this.onCloseTap,
    this.image,
  });

  final String? username;
  final String? image;
  final VoidCallback onCloseTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        CircleAvatar(
          backgroundColor: Colors.amber,
          backgroundImage: image != null ? NetworkImage(image!) : null,
        ),
        const SizedBox(width: 10),
        Text(username ?? '---', style: s14W400(context).copyWith(color: Colors.white)),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.ellipsis),
          color: Colors.white,
        ),
        IconButton(
            onPressed: onCloseTap,
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            )),
      ],
    );
  }
}
