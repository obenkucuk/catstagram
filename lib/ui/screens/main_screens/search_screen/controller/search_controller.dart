import 'package:catstagram/core/services/session_service/session_service.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import '../../../../../core/models/cats_from_tag_response_model.dart';
import '../../../../../core/services/network_service/repositories.dart';
import '../widget/search_history.dart';

enum SearchKeys { updateList }

class SearchXController extends GetxController {
  final scaffoldKey = GlobalKey();

  BuildContext get context => scaffoldKey.currentContext!;
  late final FocusNode searchFocusNode = FocusNode()..addListener(_searchFocusListener);
  final RxBool isOverlayVisible = false.obs;
  final TextEditingController searchTextController = TextEditingController();

  void _searchFocusListener() {
    if (searchFocusNode.hasFocus) {
      showSearch();
    }
  }

  final RxList<SearchHistoryModel> searchHistoryList = <SearchHistoryModel>[
    SearchHistoryModel(keyword: 'deneme'),
  ].obs;

  final overlayDimensionKey = GlobalKey();
  OverlayEntry? overlayEntry;
  OverlayState? overlayState;

  implementSearch(String searchKey) {
    /// TODO: arama yap ve history listesine ekle
    ///

    var isKeywordExist = searchHistoryList.any((e) => e.keyword == searchKey);

    if (!isKeywordExist) {
      var newSearchHistory = SearchHistoryModel(keyword: searchKey);
      searchHistoryList.add(newSearchHistory);
    }
  }

  deleteFromSearchHistory(String searchKey) {
    var isKeywordExist = searchHistoryList.any((e) => e.keyword == searchKey);

    if (isKeywordExist) {
      searchHistoryList.removeWhere((e) => e.keyword == searchKey);
    }

    update([SearchKeys.updateList]);
  }

//for showing the search history overlay
  Future<void> showSearch() async {
    isOverlayVisible.value = true;

    RenderBox renderBox = overlayDimensionKey.currentContext!.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);

    overlayEntry = OverlayEntry(builder: (context) {
      return GetBuilder<SearchXController>(
          id: SearchKeys.updateList,
          init: SearchXController(),
          builder: (controller) {
            return SearchHistory(
              searchStatus: SearchStatus.history,
              offset: offset,
              size: renderBox.size,
              list: searchHistoryList,
              onDelete: (searchKey) => deleteFromSearchHistory(searchKey),
              onTap: (value) {
                searchTextController.text = value;
                searchTextController.selection = TextSelection.fromPosition(TextPosition(offset: value.length));
              },
            );
          });
    });
    overlayState = Overlay.of(context);
    overlayState!.insert(overlayEntry!);
  }

  Future<void> hideSearch() async {
    searchTextController.clear();
    FocusScope.of(context).unfocus();
    isOverlayVisible.value = false;
    if (overlayEntry == null) return;
    overlayEntry!.remove();
    overlayEntry = null;
  }

  late final ScrollController searchScrollController;

  final RxList<CatFromTagResponseModel> dataSearchList = <CatFromTagResponseModel>[].obs;

  final allTags = SessionService.instance.allTags;

  Future<void> fetchData() async {
    allTags.shuffle();
    allTags.take(8).forEach((element) async {
      var res = await Repository.instance.getCatsFromTag(element);
      dataSearchList.addAll(res.data);
    });
  }

  bool shuldSearchLazyLoad = true;
  Future<void> _searchLazyLoad() async {
    /// for lazy load

    if (searchScrollController.position.maxScrollExtent - 20 <= searchScrollController.offset) {
      try {
        if (shuldSearchLazyLoad) {
          shuldSearchLazyLoad = false;
          allTags.shuffle();
          var res = await Repository.instance.getCatsFromTag(allTags.first);

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
