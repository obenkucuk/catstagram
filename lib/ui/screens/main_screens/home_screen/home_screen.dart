import 'package:catstagram/ui/screens/main_screens/home_screen/controller/home_controller.dart';
import 'package:catstagram/ui/screens/main_screens/home_screen/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => const HomeView(),
    );
  }
}
