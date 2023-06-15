import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../../core/models/story_model.dart';
import '../story_screen/controller/story_controller.dart';
import 'view/story_view.dart';

class StoryScreen extends StatelessWidget {
  final List<StoryModel> elements;
  final int initialPeopleIndex;
  const StoryScreen({super.key, required this.elements, required this.initialPeopleIndex});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoryController>(
      init: StoryController(elements: elements, initialPeopleIndex: initialPeopleIndex),
      builder: (controller) => const StoryView(),
    );
  }
}
