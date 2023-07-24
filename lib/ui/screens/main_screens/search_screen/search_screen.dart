import 'package:catstagram/ui/screens/main_screens/search_screen/controller/search_controller.dart';
import 'package:catstagram/ui/screens/main_screens/search_screen/view/search_view.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchControllerX>(
      init: SearchControllerX(),
      builder: (controller) => const SearchView(),
    );
  }
}
