import 'package:catstagram/core/services/localization_service/localization_service.dart';
import 'package:catstagram/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/settings_controller.dart';
import '../custom_dropdown/custom_dropdown.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(appLocalization(context).settings),
        ),
        centerTitle: false,
      ),
      key: controller.scaffoldKey,
      body: Obx(() {
        if (controller.loadingStatus.value != LoadingStatus.loaded) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(appLocalization(context).changeLanguage),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: CupertinoSlidingSegmentedControl<Brightness>(
                          groupValue: controller.brigthtness.value,
                          children: {
                            Brightness.light: createSegment(context, appLocalization(context).lightMode),
                            Brightness.dark: createSegment(context, appLocalization(context).darkMode),
                          },
                          onValueChanged: (value) => controller.changeTheme(value),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(appLocalization(context).changeTheme),
                      const Spacer(),
                      CustomDropdown(
                        title: controller.locale.value.languageCode == 'tr' ? 0 : 1,
                        dropdownWidth: MediaQuery.of(context).size.width * 0.3,
                        textStyle: s14W400(context),
                        items: controller.dropdownItems,
                        onSelected: (index) => controller.changeLocalization(index),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }

  Widget createSegment(BuildContext context, String text) =>
      ColoredBox(color: Colors.transparent, child: Text(text, style: s14W400(context)));
}
