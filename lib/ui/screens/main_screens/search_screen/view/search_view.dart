import 'package:catstagram/core/extensions/to_cats_id_url.dart';
import 'package:catstagram/core/services/localization_service/localization_service.dart';
import 'package:catstagram/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../search_screen/controller/search_controller.dart';

class SearchView extends GetView<SearchXController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      body: Obx(
        () {
          return CustomScrollView(
            physics: controller.isOverlayVisible.value
                ? const NeverScrollableScrollPhysics()
                : const AlwaysScrollableScrollPhysics(),
            controller: controller.searchScrollController,
            slivers: [
              SliverAppBar(
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
                    style: s12W300(context),
                    placeholder: appLocalization(context).searchPlaceholder,
                    onSubmitted: (searchKey) => controller.implementSearch(searchKey),
                  ),
                ),
              ),
              if (controller.dataSearchList.isNotEmpty)
                SliverGrid.builder(
                  itemCount: controller.dataSearchList.isEmpty ? 8 : controller.dataSearchList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    return Image.network(
                      (controller.dataSearchList[index].id ?? 'H2NHTuNktH1nAf4a').toCatsIdUrl,
                      errorBuilder: (context, error, stackTrace) => const CircularProgressIndicator.adaptive(),
                      fit: BoxFit.cover,
                    );
                  },
                ),
              if (controller.shuldSearchLazyLoad && controller.dataSearchList.isNotEmpty)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: CircularProgressIndicator.adaptive(),
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
