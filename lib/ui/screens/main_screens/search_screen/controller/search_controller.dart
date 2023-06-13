import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import '../../../../../core/models/cats_from_tag_response_model.dart';
import '../../../../../core/services/network_service/repositories.dart';
import '../widget/search_history.dart';

class SearchXController extends GetxController {
  final scaffoldKey = GlobalKey();

  BuildContext get context => scaffoldKey.currentContext!;
  late final FocusNode searchFocusNode = FocusNode()..addListener(_searchFocusListener);
  final RxBool isOverlayVisible = false.obs;

  _searchFocusListener() {
    if (searchFocusNode.hasFocus) {
      showSearch();
    }
  }

  final RxList<SearchHistoryModel> searchHistoryList = <SearchHistoryModel>[
    SearchHistoryModel(keyword: 'deneme'),
  ].obs;

  final GlobalKey overlayDimensionKey = GlobalKey();
  OverlayEntry? overlayEntry;
  OverlayState? overlayState;

  implementSearch(String value) {
    /// TODO: arama yap ve history listesine ekle
    ///

    var newSearchHistory = SearchHistoryModel(keyword: value);
    searchHistoryList.add(newSearchHistory);
  }

//for showing the search history overlay
  void showSearch() {
    isOverlayVisible.value = true;

    RenderBox renderBox = overlayDimensionKey.currentContext!.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);

    overlayEntry = OverlayEntry(builder: (context) {
      return SearchHistory(
        offset: offset,
        size: renderBox.size,
        list: searchHistoryList,
        onDelete: (value) => print(value),
        onTap: (value) => print(value),
      );
    });
    overlayState = Overlay.of(context);
    overlayState!.insert(overlayEntry!);
  }

  void hideSearch() {
    FocusScope.of(context).unfocus();
    isOverlayVisible.value = false;
    if (overlayEntry == null) return;
    overlayEntry!.remove();
    overlayEntry = null;
  }

  late final ScrollController searchScrollController;

  final RxList<CatFromTagResponseModel> dataSearchList = <CatFromTagResponseModel>[].obs;

  List<String> _allTags = [];

  Future<void> fetchData() async {
    var response = await Repository.instance.getTags();

    _allTags = response.data.tags;

    _allTags.shuffle();

    _allTags.take(8).forEach((element) async {
      var res = await Repository.instance.getCatsFromTag(element);
      dataSearchList.addAll(res.data);
    });
  }

  bool shuldSearchLazyLoad = true;
  Future<void> _searchLazyLoad() async {
    /// for lazy load
    /// if the scroll is at the max scroll extent - 400, it will execute the [search] method.
    /// nextPage is the next page url from the api.
    /// nextPage can be null. Its for not sending too many request to the api and detect the if next page is exist.

    if (searchScrollController.position.maxScrollExtent - 20 <= searchScrollController.offset) {
      try {
        if (shuldSearchLazyLoad) {
          shuldSearchLazyLoad = false;
          _allTags.shuffle();

          var res = await Repository.instance.getCatsFromTag(_allTags.first);

          dataSearchList.value += res.data;

          shuldSearchLazyLoad = true;
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

class SearchHistoryModel {
  final String keyword;
  final String? imageUrl;
  final String? type;

  SearchHistoryModel({required this.keyword, this.imageUrl, this.type});
}
