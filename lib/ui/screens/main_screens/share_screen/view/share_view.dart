import 'package:catstagram/core/services/localization_service/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';
import '../../../../../constants/assets_constants.dart';
import '../controller/share_controller.dart';

class ShareView extends GetView<ShareController> {
  const ShareView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: controller.controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: controller.controller.value.aspectRatio,
                child: VideoPlayer(controller.controller),
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.controller.value.isPlaying ? controller.controller.pause() : controller.controller.play();
        },
        child: Icon(
          controller.controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),

      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       FractionallySizedBox(
      //         widthFactor: 0.4,
      //         child: Lottie.asset(AssetConstants.loadingCat),
      //       ),
      //       Text(appLocalization(context).sleeping)
      //     ],
      //   ),
      // ),
    );
  }
}
