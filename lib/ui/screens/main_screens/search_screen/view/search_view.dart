import 'package:catstagram/core/extensions/to_cats_id_url.dart';
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
          int itemCount = (controller.dataSearchList.isEmpty ? 8 : controller.dataSearchList.length);

          return CustomScrollView(
            controller: controller.searchScrollController,
            slivers: [
              SliverAppBar(
                floating: true,
                title: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: AnimatedFractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          duration: const Duration(milliseconds: 200),
                          key: controller.overlayDimensionKey,
                          widthFactor: controller.isOverlayVisible.value ? 0.95 : 1,
                          child: CupertinoSearchTextField(
                            focusNode: controller.searchFocusNode,
                            style: s12W300,
                            placeholder: 'Search Cute Cat',
                          ),
                        ),
                      ),
                      AnimatedSlide(
                        offset: controller.isOverlayVisible.value ? Offset.zero : Offset(10, 0),
                        duration: Duration(milliseconds: 300),
                        child: Text(
                          'Cancel',
                          style: s12W600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (controller.dataSearchList.isNotEmpty)
                SliverGrid.builder(
                  itemCount: itemCount,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return Image.network(
                      (controller.dataSearchList[index].data!.first.id ?? 'H2NHTuNktH1nAf4a').toCatsIdUrl,
                      errorBuilder: (context, error, stackTrace) => const CircularProgressIndicator.adaptive(),
                      fit: BoxFit.cover,
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
