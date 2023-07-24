import 'package:catstagram/core/models/story_model.dart';
import 'package:catstagram/ui/screens/other_screens/story_screen/controller/story_controller.dart';
import 'package:catstagram/ui/screens/other_screens/story_screen/view/story_view.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

final class StoryScreen extends StatelessWidget {
  const StoryScreen({
    required this.elements,
    required this.initialPeopleIndex,
    super.key,
  });

  final List<StoryModel> elements;
  final int initialPeopleIndex;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoryController>(
      init: StoryController(elements: elements, initialPeopleIndex: initialPeopleIndex),
      builder: (controller) => const StoryView(),
    );
  }
}
