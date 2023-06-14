import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../../components/story_transform/cube_transform.dart';
import '../../../../../core/logger.dart';
import '../../story_screen/controller/story_controller.dart';
import '../model/story_page_element_model.dart';

class StoryView extends GetView<StoryController> {
  const StoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.pageKey,
      body: GestureDetector(
        onVerticalDragStart: (a) {
          Log.print("verti");
          controller.myTimer.pause();
        },
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! > 100) Navigator.pop(context);
          controller.myTimer.resume();

          Log.print("end");
        },
        child: PageView.builder(
          onPageChanged: (value) {
            controller.myTimer.resetTime();
          },
          physics: const BouncingScrollPhysics(),
          controller: controller.storyController,
          itemCount: controller.elements.length,
          scrollBehavior: ScrollConfiguration.of(context).copyWith(
            scrollbars: false,
            overscroll: false,
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
          ),
          itemBuilder: (context, index) {
            return Obx(
              () => const CubeTransform().transform(
                context,
                SingleCat(elements: controller.elements[index]),
                index,
                controller.currentPage.value,
                controller.delta.value,
                controller.elements.length,
              ),
            );
          },
        ),
      ),
    );
  }
}

class SingleCat extends StatelessWidget {
  final StoryPageElements elements;
  const SingleCat({super.key, required this.elements});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(
        elements.elements.length * 70,
        elements.elements.length * 70,
        elements.elements.length * 70,
        1,
      ),
      alignment: Alignment.center,
      child: const Text('cdsvds'),
    );
  }
}
