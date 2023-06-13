import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../widget/single_post.dart';
import '../widget/single_story.dart';

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
                  IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.heart)),
                  IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.text_bubble)),
                ],
              ),

              /// Stories
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 120,
                  child: ColoredBox(
                    color: Colors.transparent,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.dataPost.length > 10 ? 10 : controller.dataPost.length,
                      itemBuilder: (context, index) => SingleStory(cat: controller.dataPost[index]),
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 1, child: ColoredBox(color: Theme.of(context).dividerColor))),

              /// Post List
              if (controller.dataPost.isNotEmpty)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var itemCount = (controller.dataPost.isEmpty ? 5 : controller.dataPost.length) + 1;

                      if (itemCount == index + 1) {
                        return const Center(child: SizedBox(height: 100, child: CircularProgressIndicator.adaptive()));
                      } else if (controller.dataPost.isNotEmpty) {
                        return SinglePost(catList: controller.dataPost[index]);
                      } else {
                        return const SinglePost();
                      }
                    },
                    childCount: (controller.dataPost.isEmpty ? 5 : controller.dataPost.length) + 1,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
