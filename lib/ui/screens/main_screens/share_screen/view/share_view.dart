import 'package:catstagram/constants/assets_constants.dart';
import 'package:catstagram/core/services/localization_service/localization_service.dart';
import 'package:catstagram/ui/screens/main_screens/share_screen/controller/share_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show GetView;
import 'package:lottie/lottie.dart';

class ShareView extends GetView<ShareController> {
  const ShareView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FractionallySizedBox(
              widthFactor: 0.4,
              child: Lottie.asset(AssetConstants.loadingCat),
            ),
            Text(appLocalization(context).sleeping)
          ],
        ),
      ),
    );
  }
}
