import 'package:catstagram/components/lazy_load_loading_widget/lazy_load_loading_widget.dart';
import 'package:catstagram/core/extensions/to_cats_id_url.dart';
import 'package:catstagram/core/services/localization_service/localization_service.dart';
import 'package:catstagram/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../search_screen/controller/search_controller.dart';

class SearchView extends GetView<SearchControllerX> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      body: Obx(
        () {
          return SafeArea(
            child: CustomScrollView(
              physics: controller.isOverlayVisible.value
                  ? const NeverScrollableScrollPhysics()
                  : const AlwaysScrollableScrollPhysics(),
              controller: controller.searchScrollController,
              slivers: [
                SliverAppBar(
                  surfaceTintColor: Colors.transparent,
                  floating: true,
                  actions: [
                    AnimatedSize(
                      alignment: Alignment.centerLeft,
                      duration: const Duration(milliseconds: 200),
                      child: SizedBox(
                        width: controller.isOverlayVisible.value ? MediaQuery.of(context).size.width * .1 : 0,
                        child: AnimatedSlide(
                          offset: controller.isOverlayVisible.value ? Offset.zero : const Offset(5, 0),
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: GestureDetector(
                            onTap: controller.hideSearch,
                            child: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(appLocalization(context).cancel, style: s14W400(context)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CupertinoSearchTextField(
                      key: controller.overlayDimensionKey,
                      focusNode: controller.searchFocusNode,
                      autocorrect: false,
                      controller: controller.searchTextController,
                      style: s12W300(context),
                      placeholder: appLocalization(context).searchPlaceholder,
                      onSubmitted: (searchKey) => controller.implementSearch(searchKey),
                      onChanged: (value) => controller.listenChangingSearchKey(value),
                    ),
                  ),
                ),
                if (controller.dataList.isNotEmpty)
                  SliverGrid.builder(
                    itemCount: controller.dataList.isEmpty ? 8 : controller.dataList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      return Image.network(
                        (controller.dataList[index].id ?? 'H2NHTuNktH1nAf4a').toCatsIdUrl,
                        errorBuilder: (context, error, stackTrace) => const CircularProgressIndicator.adaptive(),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                if (controller.shuldSearchViewLazyLoad && controller.dataList.isNotEmpty)
                  const SliverToBoxAdapter(child: LazyLoadLoadingWidget())
              ],
            ),
          );
        },
      ),
    );
  }
}
