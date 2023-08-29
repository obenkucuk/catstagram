import 'dart:async';
import 'dart:ui';
import 'package:catstagram/components/story_transform/cube_transform.dart';
import 'package:catstagram/constants/hero_tags.dart';
import 'package:catstagram/core/extensions/to_cats_id_url.dart';
import 'package:catstagram/core/models/cats_from_tag_response_model.dart';
import 'package:catstagram/theme/text_styles.dart';
import 'package:catstagram/ui/screens/other_screens/story_screen/controller/story_controller.dart';
import 'package:catstagram/ui/screens/other_screens/story_screen/controller/story_timer_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:video_player/video_player.dart';

part '../widget/duration_indicator_widget.dart';
part '../widget/story_user_area_widget.dart';
part '../widget/story_video_player_widget.dart';

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
          child: GetBuilder<StoryController>(
            id: StoryUpdateKeys.storyScreen,
            builder: (controller) {
              return PageView.builder(
                pageSnapping: false,
                onPageChanged: (value) {
                  controller.storyTimer.resetTime();
                  controller.currentStoryIndex.value = 0;
                  controller.indicatorValue.value = 0;
                },
                clipBehavior: Clip.antiAliasWithSaveLayer,
                controller: controller.peopleController,
                itemCount: controller.elements.length,
                scrollBehavior: ScrollConfiguration.of(context).copyWith(
                  scrollbars: false,
                  overscroll: false,
                  dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
                ),
                itemBuilder: (context, peopleIndex) {
                  final model = controller.elements[peopleIndex].storyList[controller.currentStoryIndex.value];

                  return Obx(
                    () {
                      return ColoredBox(
                        color: Colors.black,
                        child: GestureDetector(
                          onLongPressDown: (details) {
                            controller.storyTimer.pause();
                          },
                          onLongPressEnd: (details) => controller.storyTimer.resume(),
                          onTapDown: (details) => controller.storyTimer.pause(),
                          onTapUp: (position) => controller.tapHandler(position),
                          onVerticalDragStart: (_) => controller.storyTimer.pause(),
                          onVerticalDragEnd: (details) {
                            if (details.primaryVelocity! > 100) Navigator.pop(context);
                            controller.storyTimer.resume();
                          },
                          child: CubeTransformWidget(
                            index: peopleIndex,
                            pageDelta: controller.delta.value,
                            currentPage: controller.currentPage.value,
                            child: SafeArea(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                child: ColoredBox(
                                  color: Colors.grey,
                                  child: Stack(
                                    children: [
                                      /// Story Content
                                      if (model.contentType == ReqContentType.video)
                                        _StoryVideoPlayerWidget(
                                          storyTimer: controller.storyTimer,
                                          url: model.videoUrl!,
                                        ),
                                      if (model.contentType == ReqContentType.photo)
                                        Image.network(
                                          model.id!.toCatsIdUrl,
                                          width: double.maxFinite,
                                          height: double.maxFinite,
                                          fit: BoxFit.contain,
                                        ),

                                      /// indicator
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          _DurationIndicatorWidget(
                                            indicatorLenght: controller.elements[peopleIndex].storyList.length,
                                            currentStoryIndex: controller.currentStoryIndex.value,
                                            storyTimer: controller.storyTimer,
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
              );
            },
          ),
        ),
      ),
    );
  }
}
