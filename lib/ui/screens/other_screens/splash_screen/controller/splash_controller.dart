import 'package:catstagram/core/router/route_names.dart';
import 'package:catstagram/core/services/network_service/repositories.dart';
import 'package:catstagram/core/services/router_service/router_argsuments_model.dart';
import 'package:catstagram/core/services/router_service/router_enums.dart';
import 'package:catstagram/core/services/router_service/router_service.dart';
import 'package:catstagram/core/services/session_service/session_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  /// fetch all tags from the api and save it in the session service to use it in the app
  Future<void> _getTags() async {
    var allTags = <String>[];

    try {
      final response = await Repository.instance.getTags();

      if (response.statusCode == 200) {
        allTags = response.data.tags
          ..removeWhere((element) => element.contains(' '))
          ..removeWhere((element) => element.contains('#'))
          ..removeWhere((element) => element.contains('@'))
          ..removeWhere((element) => element.length < 3)
          ..shuffle();

        SessionService.instance.allTags = allTags;
      }
    } catch (e) {
      debugPrint('An error occured!');
    }
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await _getTags();

    /// İki saniye beklettikten sonra main page'a yönlendirir.
    await Future.delayed(
      const Duration(seconds: 2),
      () => RouterService.instance.replaceNamed(
        RoutesNames.main,
        args: RouterArgumentsModel(
          appPageTransition: AppPageTransition.fade,
        ),
      ),
    );
  }
}
