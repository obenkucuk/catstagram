import 'package:catstagram/constants/assets_constants.dart';
import 'package:catstagram/core/config/app_config.dart';
import 'package:catstagram/ui/screens/other_screens/splash_screen/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lottie/lottie.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.4,
              child: Lottie.asset(AssetConstants.splashAnimation),
            ),
          ),
          const CircularProgressIndicator.adaptive(),
          const Spacer(),
          Text(AppConfig.instance.appName),
          SizedBox(height: MediaQuery.of(context).padding.bottom > 0.0 ? MediaQuery.of(context).padding.bottom : 10),
        ],
      ),
    );
  }
}
