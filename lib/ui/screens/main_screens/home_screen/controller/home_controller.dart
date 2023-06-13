import 'package:catstagram/core/services/session_service/session_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../../../core/logger.dart';
import '../../../../../core/models/cats_from_tag_response_model.dart';
import '../../../../../core/services/network_service/repositories.dart';
import '../../../../../main/main_screen.dart';

class HomeController extends GetxController {
  final scaffoldKey = GlobalKey();
  BuildContext get context => scaffoldKey.currentContext!;

  late final ScrollController postScrollController;

  final RxList<String> _selectedPostTags = <String>[].obs;
  final RxList<CatFromTagResponseModel> dataPost = <CatFromTagResponseModel>[].obs;

  final allTags = SessionService.instance.allTags;

  Future<void> fetchData() async {
    _selectedPostTags.addAll(allTags.take(5));

    _selectedPostTags.forEach((element) async {
      var res = await Repository.instance.getCatsFromTag(element);
      dataPost.addAll(res.data);
    });
  }

  bool shuldPostLazyLoad = true;
  Future<void> _postLazyLoad() async {
    /// for lazy load

    var direction = postScrollController.position.userScrollDirection;

    MainScreenInheritedWidget.of(context).hideTabBar(direction == ScrollDirection.forward ? true : false);

    if (postScrollController.position.maxScrollExtent - 20 <= postScrollController.offset) {
      try {
        if (shuldPostLazyLoad) {
          shuldPostLazyLoad = false;
          allTags.shuffle();

          var res = await Repository.instance.getCatsFromTag(allTags.first);
          dataPost.value += res.data;

          Log.print("m1");
          shuldPostLazyLoad = true;
        }
      } catch (_) {
        shuldPostLazyLoad = true;
      }
    }
  }

  @override
  void onInit() {
    super.onInit();

    postScrollController = ScrollController()..addListener(_postLazyLoad);

    fetchData();
  }

  @override
  void onClose() {
    postScrollController.removeListener(_postLazyLoad);
    postScrollController.dispose();

    super.onClose();
  }
}
