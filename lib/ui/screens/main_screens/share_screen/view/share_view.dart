import 'package:catstagram/core/services/localization_service/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../../constants/assets_constants.dart';
import '../controller/share_controller.dart';

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
