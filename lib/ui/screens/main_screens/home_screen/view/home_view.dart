import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../widget/single_post.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      body: Obx(
        () => SafeArea(
          child: CustomScrollView(
            controller: controller.postScrollController,
            slivers: [
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                surfaceTintColor: Colors.transparent,

                /// shape: const ContinuousRectangleBorder(side: BorderSide(color: Colors.black)),
                /// backgroundColor: Colors.amberAccent,
                floating: true,
                leadingWidth: MediaQuery.of(context).size.width * .5,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Catstagram',
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                    ),
                  ),
                  const Spacer(),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
                ],
              ),

              /// Post List
              if (controller.dataPostList.isNotEmpty)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var itemCount = (controller.dataPostList.isEmpty ? 5 : controller.dataPostList.length) + 1;

                      if (itemCount == index + 1) {
                        return const Center(child: SizedBox(height: 100, child: CircularProgressIndicator.adaptive()));
                      } else if (controller.dataPostList.isNotEmpty) {
                        return SinglePost(catList: controller.dataPostList[index].data);
                      } else {
                        return const SinglePost();
                      }
                    },
                    childCount: (controller.dataPostList.isEmpty ? 5 : controller.dataPostList.length) + 1,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
