import 'package:catstagram/components/lazy_load_loading_widget/lazy_load_loading_widget.dart';
import 'package:catstagram/constants/hero_tags.dart';
import 'package:catstagram/ui/screens/main_screens/home_screen/controller/home_controller.dart';
import 'package:catstagram/ui/screens/main_screens/home_screen/widget/single_post.dart';
import 'package:catstagram/ui/screens/main_screens/home_screen/widget/single_story.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      key: controller.scaffoldKey,
      body: Obx(
        () => SafeArea(
          child: CustomScrollView(
            controller: controller.postScrollController,
            slivers: [
              /// App Bar for the home screen
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                surfaceTintColor: Colors.transparent,
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

              /// Stories List view at the top of the home screen
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 120,
                  child: Hero(
                    tag: HeroTags.story,
                    child: ColoredBox(
                      color: Colors.transparent,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.dataStories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => controller.goToStory(index),
                            child: SingleStory(
                              name: controller.dataStories[index].index.toString(),
                              isSeen: controller.dataStories[index].isSeen.value,
                              imageUrl: controller.dataStories[index].image,
                            ),
                          );
                        },
                      ),
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
                      final itemCount = (controller.dataPost.isEmpty ? 5 : controller.dataPost.length) + 1;

                      if (itemCount == index + 1) {
                        return const LazyLoadLoadingWidget();
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
