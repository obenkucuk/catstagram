import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../../core/models/story_model.dart';
import '../story_screen/controller/story_controller.dart';
import 'view/story_view.dart';

class StoryScreen extends StatelessWidget {
  final List<StoryModel> model;
  final int index;
  const StoryScreen({super.key, required this.model, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoryController>(
      init: StoryController(model, index),
      builder: (controller) => const StoryView(),
    );
  }
}
