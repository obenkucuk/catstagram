import 'package:catstagram/core/router/route_names.dart';
import 'package:catstagram/core/services/router_service/router_enums.dart';
import 'package:catstagram/core/services/router_service/router_service.dart';
import 'package:catstagram/core/services/session_service/session_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../../../../../core/models/cats_from_tag_response_model.dart';
import '../../../../../core/services/network_service/repositories.dart';
import '../../../../../core/services/router_service/router_argsuments_model.dart';
import '../../../../../main/main_screen.dart';

class HomeController extends GetxController {
  final scaffoldKey = GlobalKey();
  BuildContext get context => scaffoldKey.currentContext!;
  late final ScrollController postScrollController;

  final RxList<CatFromTagResponseModel> dataPost = <CatFromTagResponseModel>[].obs;
  final allTags = SessionService.instance.allTags;
  bool shuldPostLazyLoad = true;

  /// fetch data from the api to show in the post list and story view
  Future<void> fetchData() async {
    var selectedPostTags = <String>[];
    allTags.shuffle();
    selectedPostTags.addAll(allTags.take(5));

    for (var element in selectedPostTags) {
      try {
        var res = await Repository.instance.getCatsFromTag(element);
        if (res.statusCode == 200) dataPost.addAll(res.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  /// go to story screen when the user tap on the story item
  void goToStory() {
    RouterService.instance.pushNamed(RoutesNames.story,
        args: RouterArgumentsModel<int>(appPageTransition: AppPageTransition.slideUp, extra: 5));
  }

  /// when user go to the end of list items load more data
  Future<void> _postLazyLoad() async {
    var direction = postScrollController.position.userScrollDirection;

    /// hide the tab bar when the user scroll down and show it when the user scroll up
    MainScreenInheritedWidget.of(context).hideTabBar(direction == ScrollDirection.forward ? true : false);

    if (postScrollController.position.maxScrollExtent - 20 <= postScrollController.offset) {
      try {
        if (shuldPostLazyLoad) {
          shuldPostLazyLoad = false;
          await fetchData();
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
