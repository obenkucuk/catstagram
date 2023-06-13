import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../../../core/logger.dart';
import '../../../../../core/models/cats_from_tag_response_model.dart';
import '../../../../../core/services/network_service/base_http_model.dart';
import '../../../../../core/services/network_service/repositories.dart';
import '../../../../../main/main_screen.dart';

class HomeController extends GetxController {
  final scaffoldKey = GlobalKey();
  BuildContext get context => scaffoldKey.currentContext!;

  late final ScrollController postScrollController;
  late final ScrollController storyScrollController;

  final RxList<String> _selectedPostTags = <String>[].obs;

  final RxList<BaseHttpModel<List<CatFromTagResponseModel>>> dataPostList =
      <BaseHttpModel<List<CatFromTagResponseModel>>>[].obs;

  final RxList<BaseHttpModel<List<CatFromTagResponseModel>>> dataStoryList =
      <BaseHttpModel<List<CatFromTagResponseModel>>>[].obs;

  List<String> _allTags = [];
  Future<void> fetchData() async {
    var response = await Repository.instance.getTags();

    _allTags = response.data.tags;

    response.data.tags.removeWhere((element) => element.contains(' '));
    response.data.tags.removeWhere((element) => element.contains('#'));
    response.data.tags.removeWhere((element) => element.contains('@'));
    response.data.tags.removeWhere((element) => element.length < 3);

    response.data.tags.shuffle();

    response.data.tags.shuffle();
    _selectedPostTags.addAll(response.data.tags.take(5));

    dataPostList.value =
        await Future.wait(_selectedPostTags.map((element) => Repository.instance.getCatsFromTag(element)));
  }

  bool shuldPostLazyLoad = true;
  double firstScrollPosition = 0;
  void _postLazyLoad() {
    /// for lazy load
    /// if the scroll is at the max scroll extent - 400, it will execute the [search] method.
    /// nextPage is the next page url from the api.
    /// nextPage can be null. Its for not sending too many request to the api and detect the if next page is exist.

    var direction = postScrollController.position.userScrollDirection;

    MainScreenInheritedWidget.of(context).hideTabBar(direction == ScrollDirection.forward ? true : false);

    // if (postScrollController.offset > 80 &&
    //     postScrollController.position.userScrollDirection == ScrollDirection.reverse) {
    //   MainScreenInheritedWidget.of(context).hideTabBar(false);
    // } else {
    //   MainScreenInheritedWidget.of(context).hideTabBar(true);
    // }

    if (postScrollController.position.maxScrollExtent - 20 <= postScrollController.offset) {
      try {
        if (shuldPostLazyLoad) {
          shuldPostLazyLoad = false;
          _allTags.shuffle();
          Repository.instance.getCatsFromTag(_allTags.first).then((value) {
            dataPostList.value += [value];

            Log.print("m1");
            shuldPostLazyLoad = true;
          });
        }
      } catch (_) {
        shuldPostLazyLoad = true;
      }
    }
  }

  bool shuldStoryLazyLoad = true;
  void _storyLazyLoad() {
    /// for lazy load
    /// if the scroll is at the max scroll extent - 400, it will execute the [search] method.
    /// nextPage is the next page url from the api.
    /// nextPage can be null. Its for not sending too many request to the api and detect the if next page is exist.

    if (storyScrollController.position.maxScrollExtent - 10 <= storyScrollController.offset) {
      try {
        if (shuldStoryLazyLoad) {
          shuldStoryLazyLoad = false;
          _allTags.shuffle();
          Repository.instance.getCatsFromTag(_allTags.first).then((value) {
            dataStoryList.value += [value];

            Log.print("m1");
            shuldStoryLazyLoad = true;
          });
        }
      } catch (_) {
        shuldStoryLazyLoad = true;
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    postScrollController = ScrollController()..addListener(_postLazyLoad);
    storyScrollController = ScrollController()..addListener(_storyLazyLoad);

    fetchData();
  }

  @override
  void onClose() {
    postScrollController.dispose();

    postScrollController.removeListener(_postLazyLoad);

    super.onClose();
  }
}
