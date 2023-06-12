import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import '../../../../../core/models/cats_from_tag_response_model.dart';
import '../../../../../core/services/network_service/base_http_model.dart';
import '../../../../../core/services/network_service/repositories.dart';
import '../widget/search_history.dart';

class SearchXController extends GetxController {
  final scaffoldKey = GlobalKey();

  BuildContext get context => scaffoldKey.currentContext!;
  late final FocusNode searchFocusNode = FocusNode()..addListener(_searchFocusListener);
  final RxBool isOverlayVisible = false.obs;

  _searchFocusListener() {
    if (searchFocusNode.hasFocus) {
      showOverlay();
    } else {
      hideOverlay();
    }
  }

  final GlobalKey overlayDimensionKey = GlobalKey();
  OverlayEntry? overlayEntry;
  OverlayState? overlayState;

//for showing the search history overlay
  void showOverlay() {
    isOverlayVisible.value = true;

    RenderBox renderBox = overlayDimensionKey.currentContext!.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);

    overlayEntry = OverlayEntry(builder: (context) {
      return SearchHistory(
        offset: offset,
        size: renderBox.size,
        list: ['1', '2', '3'],
        onDelete: (value) => print(value),
        onTap: (value) => print(value),
      );
    });
    overlayState = Overlay.of(context);
    overlayState!.insert(overlayEntry!);
  }

  void hideOverlay() {
    isOverlayVisible.value = false;
    if (overlayEntry == null) return;
    overlayEntry!.remove();
    overlayEntry = null;
  }

  late final ScrollController searchScrollController;

  final RxList<BaseHttpModel<List<CatFromTagResponseModel>>> dataSearchList =
      <BaseHttpModel<List<CatFromTagResponseModel>>>[].obs;

  List<String> _allTags = [];
  Future<void> fetchData() async {
    var response = await Repository.instance.getTags();

    _allTags = response.data.tags;

    _allTags.shuffle();

    dataSearchList.value =
        await Future.wait(List.from(_allTags.take(8)).map((element) => Repository.instance.getCatsFromTag(element)));
  }

  bool shuldSearchLazyLoad = true;
  void _searchLazyLoad() {
    /// for lazy load
    /// if the scroll is at the max scroll extent - 400, it will execute the [search] method.
    /// nextPage is the next page url from the api.
    /// nextPage can be null. Its for not sending too many request to the api and detect the if next page is exist.

    if (searchScrollController.position.maxScrollExtent - 10 <= searchScrollController.offset) {
      try {
        print("object");
        if (shuldSearchLazyLoad) {
          shuldSearchLazyLoad = false;
          _allTags.shuffle();
          Repository.instance.getCatsFromTag(_allTags.first).then((value) {
            dataSearchList.value += [value];

            shuldSearchLazyLoad = true;
          });
        }
      } catch (_) {
        shuldSearchLazyLoad = true;
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
    searchScrollController = ScrollController()..addListener(_searchLazyLoad);
  }

  @override
  void onClose() {
    searchScrollController.removeListener(_searchLazyLoad);
    super.onClose();
  }
}
