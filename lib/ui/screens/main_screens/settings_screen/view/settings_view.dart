import 'package:catstagram/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../theme/material_inherited.dart';
import '../controller/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: controller.scaffoldKey,
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxScroller) {
              return [const CupertinoSliverNavigationBar(largeTitle: Text('Settings'))];
            },
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Text('Change Theme'),
                      const Spacer(),
                      CupertinoSlidingSegmentedControl<Brightness>(
                        groupValue: controller.brigthtness.value,
                        children: {
                          Brightness.light: createSegment("Light"),
                          Brightness.dark: createSegment("Dark"),
                        },
                        onValueChanged: (value) => controller.changeTheme(value),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget createSegment(String text) => ColoredBox(color: Colors.transparent, child: Text(text, style: s14W400));
}
