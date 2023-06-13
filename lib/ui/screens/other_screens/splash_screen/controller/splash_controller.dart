import 'package:catstagram/core/services/session_service/session_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/router/route_names.dart';
import '../../../../../core/services/network_service/repositories.dart';
import '../../../../../core/services/router_service/router_argsuments_model.dart';
import '../../../../../core/services/router_service/router_enums.dart';
import '../../../../../core/services/router_service/router_service.dart';

class SplashController extends GetxController {
  Future<void> _getTags() async {
    List<String> allTags = [];

    try {
      var response = await Repository.instance.getTags();

      if (response.statusCode == 200) {
        allTags = response.data.tags;

        allTags.removeWhere((element) => element.contains(' '));
        allTags.removeWhere((element) => element.contains('#'));
        allTags.removeWhere((element) => element.contains('@'));
        allTags.removeWhere((element) => element.length < 3);
        allTags.shuffle();

        SessionService.instance.allTags = allTags;
      }
    } catch (e) {
      debugPrint('An error occured!');
    }
  }

  @override
  void onReady() async {
    super.onReady();
    await _getTags();

    /// İki saniye beklettikten sonra main page'a yönlendirir.
    await Future.delayed(
      const Duration(seconds: 2),
      () => RouterService.instance
          .replaceNamed(RoutesNames.main, args: RouterArgumentsModel(appPageTransition: AppPageTransition.fade)),
    );
  }
}
