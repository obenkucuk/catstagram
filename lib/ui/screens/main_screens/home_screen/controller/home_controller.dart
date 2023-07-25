import 'dart:math' show Random;
import 'package:catstagram/core/extensions/to_cats_id_url.dart';
import 'package:catstagram/core/models/cats_from_tag_response_model.dart';
import 'package:catstagram/core/models/story_model.dart';
import 'package:catstagram/core/router/route_names.dart';
import 'package:catstagram/core/services/network_service/repositories.dart';
import 'package:catstagram/core/services/router_service/router_service.dart';
import 'package:catstagram/core/services/session_service/session_service.dart';
import 'package:catstagram/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final scaffoldKey = GlobalKey();
  BuildContext get context => scaffoldKey.currentContext!;
  late final ScrollController postScrollController;

  final RxList<CatFromTagResponseModel> dataPost = <CatFromTagResponseModel>[].obs;

  final allTags = SessionService.instance.allTags;
  bool shuldPostLazyLoad = true;
  final RxList<StoryModel> dataStories = <StoryModel>[].obs;

  /// fetch data from the api to show in the post list and story view
  Future<void> fetchData() async {
    dataStories.value = SessionService.instance.dataStories;
    final selectedPostTags = <String>[];
    allTags.shuffle();
    selectedPostTags.addAll(allTags.take(5));

    for (final element in selectedPostTags) {
      try {
        final res = await Repository.instance.getCatsFromTag(element);
        if (res.statusCode == 200) dataPost.addAll(res.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    final takeNumber = dataPost.length > 6 ? 6 : dataPost.length;
    final storyPost = dataPost;
    var index = 0;
    storyPost.take(takeNumber).forEach((e) {
      storyPost.shuffle();

      final random = Random();
      final rand1 = random.nextInt(dataPost.length > 3 ? 3 : dataPost.length) + 1;
      final rand2 = random.nextInt(dataPost.length > 3 ? 3 : dataPost.length) + 1;

      final story = StoryModel(
        index: index,
        name: '${e.tags!.first}_$index',
        image: (e.id ?? 'H2NHTuNktH1nAf4a').toCatsIdUrl,
        isSeen: false.obs,
        storyList: [
          ...dataPost.take(rand1),
          CatFromTagResponseModel(
            contentType: ReqContentType.video,
            videoUrl: 'assets/video.mp4',
          ),
          ...dataPost.take(rand2),
          CatFromTagResponseModel(
            contentType: ReqContentType.video,
            videoUrl: 'assets/video2.mp4',
          ),
          ...dataPost.take(rand1),
        ],
      );
      index++;
      dataStories.add(story);
    });
  }

  /// go to story screen when the user tap on the story item
  Future<void> goToStory(int index) async {
    final storyScreenRouterModel = StoryScreenRouterModel(models: dataStories, index: index);

    await RouterService.pushNamed(
      RoutesNames.story,
      args: storyScreenRouterModel,
    );
  }

  /// when user go to the end of list items load more data
  Future<void> _postLazyLoad() async {
    final direction = postScrollController.position.userScrollDirection;

    /// hide the tab bar when the user scroll down and show it when the user scroll up
    MainScreenInheritedWidget.of(context).hideTabBar(
      val: direction == ScrollDirection.forward,
    );

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
    postScrollController
      ..removeListener(_postLazyLoad)
      ..dispose();
    super.onClose();
  }
}

final class StoryScreenRouterModel {
  StoryScreenRouterModel({
    required this.models,
    required this.index,
  });

  final List<StoryModel> models;
  final int index;
}
