import 'package:catstagram/ui/screens/main_screens/home_screen/controller/home_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../story_screen/controller/story_controller.dart';
import 'view/story_view.dart';

class StoryScreen extends StatelessWidget {
  final List<StoryModel> model;
  const StoryScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoryController>(
      init: StoryController(model),
      builder: (controller) => const StoryView(),
    );
  }
}
