import 'package:catstagram/core/services/network_service/repositories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/models/cats_from_tag_response_model.dart';

class ShareController extends GetxController {
  late VideoPlayerController controller;

  final RxList<CatFromTagResponseModel> videosList = <CatFromTagResponseModel>[].obs;

  getVideos() async {
    try {
      var res = await Repository.instance.getPexelsSearch('cat');

      if (res.statusCode == 200) videosList.addAll(res.data);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    controller = VideoPlayerController.asset('assets/video.mp4')..initialize().then((_) {});
  }
}
