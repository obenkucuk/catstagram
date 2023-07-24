import 'package:catstagram/ui/screens/other_screens/splash_screen/controller/splash_controller.dart';
import 'package:catstagram/ui/screens/other_screens/splash_screen/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) => const SplashView(),
    );
  }
}
