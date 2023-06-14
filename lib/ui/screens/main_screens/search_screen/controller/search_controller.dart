import 'package:catstagram/core/extensions/to_cats_id_url.dart';
import 'package:catstagram/core/services/session_service/session_service.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import '../../../../../core/models/cats_from_tag_response_model.dart';
import '../../../../../core/models/search_history_and_found_model.dart';
import '../../../../../core/services/network_service/repositories.dart';
import '../view/search_history_view.dart';

enum SearchKeys { updateSearch }

class SearchController extends GetxController {
  final scaffoldKey = GlobalKey();

  BuildContext get context => scaffoldKey.currentContext!;
  late final FocusNode searchFocusNode = FocusNode()..addListener(_searchFocusListener);
  final RxBool isOverlayVisible = false.obs;
  final TextEditingController searchTextController = TextEditingController();

  final List<SearchHistoryAndFoundModel> searchHistoryList = <SearchHistoryAndFoundModel>[
    SearchHistoryAndFoundModel(keyword: 'Temp History Item'),
  ];

  final RxList<SearchHistoryAndFoundModel> searchFoundedList = <SearchHistoryAndFoundModel>[].obs;

  final overlayDimensionKey = GlobalKey();
  OverlayEntry? overlayEntry;
  OverlayState? overlayState;
  final Rx<SearchStatus> searchStatus = Rx(SearchStatus.history);

  late final ScrollController searchScrollController;
  final RxList<CatFromTagResponseModel> dataList = <CatFromTagResponseModel>[].obs;
  final allTags = SessionService.instance.allTags;
  bool shuldSearchViewLazyLoad = true;

  /// open the search view when the search focus node has focus
  void _searchFocusListener() {
    if (searchFocusNode.hasFocus) {
      showSearch();
    }
  }

  /// search for cats from the api
  Future<void> implementSearch(String searchKey) async {
    try {
      searchStatus.value = SearchStatus.searching;
      update([SearchKeys.updateSearch]);

      var res = await Repository.instance.getCatsFromTag(searchKey);
      var modelList = res.data;

      for (var e in modelList) {
        searchFoundedList.add(
          SearchHistoryAndFoundModel(
            keyword: e.tags != null ? e.tags!.first : '',
            imageUrl: (e.id ?? 'H2NHTuNktH1nAf4a').toCatsIdUrl,
          ),
        );
      }
      searchStatus.value = SearchStatus.found;
      update([SearchKeys.updateSearch]);
    } catch (e) {
      debugPrint('An Error Occured!');
    }

    var isKeywordExist = searchHistoryList.any((e) => e.keyword == searchKey);

    if (!isKeywordExist) {
      var newSearchHistory = SearchHistoryAndFoundModel(
          keyword: searchKey, imageUrl: searchFoundedList.isNotEmpty ? searchFoundedList.first.imageUrl : null);
      searchHistoryList.add(newSearchHistory);
    }
  }

  /// delete the search key from the search history list
  void deleteFromSearchHistory(String searchKey) {
    var isKeywordExist = searchHistoryList.any((e) => e.keyword == searchKey);

    if (isKeywordExist) {
      searchHistoryList.removeWhere((e) => e.keyword == searchKey);
    }

    update([SearchKeys.updateSearch]);
  }

  /// listen to the search key changing to update the search history status
  void listenChangingSearchKey(String value) {
    if (value.isNotEmpty) {
      searchStatus.value = SearchStatus.searching;
      update([SearchKeys.updateSearch]);
    } else {
      searchStatus.value = SearchStatus.history;
      update([SearchKeys.updateSearch]);
    }
  }

  /// get the search key from the search history list to implement the search
  void getSearchKeyFromHistory(value) {
    searchTextController.text = value;
    searchTextController.selection = TextSelection.fromPosition(TextPosition(offset: value.length));
    implementSearch(value);
  }

  /// for showing the search history overlay
  Future<void> showSearch() async {
    isOverlayVisible.value = true;

    RenderBox renderBox = overlayDimensionKey.currentContext!.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);

    overlayEntry = OverlayEntry(builder: (context) {
      return GetBuilder<SearchController>(
          id: SearchKeys.updateSearch,
          init: SearchController(),
          builder: (controller) {
            return SearchHistoryView(
              searchStatus: searchStatus.value,
              offset: offset,
              size: renderBox.size,
              foundedList: searchFoundedList,
              historyList: searchHistoryList,
              onDelete: (searchKey) => deleteFromSearchHistory(searchKey),
              onTap: (value) => getSearchKeyFromHistory(value),
            );
          });
    });
    overlayState = Overlay.of(context);
    overlayState!.insert(overlayEntry!);
  }

  /// for hiding the search history overlay
  Future<void> hideSearch() async {
    searchFoundedList.clear();
    searchStatus.value = SearchStatus.history;
    searchTextController.clear();
    FocusScope.of(context).unfocus();
    isOverlayVisible.value = false;
    if (overlayEntry == null) return;
    overlayEntry!.remove();
    overlayEntry = null;
  }

  /// for fetching data from the api
  Future<void> fetchData() async {
    allTags.shuffle();
    allTags.take(8).forEach((element) async {
      var res = await Repository.instance.getCatsFromTag(element);
      dataList.addAll(res.data);
    });
  }

  /// when user scroll to the end of the search view list to get more data from api
  Future<void> _searchViewLazyLoad() async {
    if (searchScrollController.position.maxScrollExtent - 20 <= searchScrollController.offset) {
      try {
        if (shuldSearchViewLazyLoad) {
          shuldSearchViewLazyLoad = false;
          allTags.shuffle();
          var res = await Repository.instance.getCatsFromTag(allTags.first);

          dataList.value += res.data;

          shuldSearchViewLazyLoad = true;
        }
      } catch (_) {
        shuldSearchViewLazyLoad = true;
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
    searchScrollController = ScrollController()..addListener(_searchViewLazyLoad);
  }

  @override
  void onClose() {
    searchScrollController.removeListener(_searchViewLazyLoad);
    super.onClose();
  }
}
