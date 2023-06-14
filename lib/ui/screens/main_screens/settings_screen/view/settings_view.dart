import 'package:catstagram/core/services/localization_service/localization_service.dart';
import 'package:catstagram/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../constants/loading_status_enums.dart';
import '../controller/settings_controller.dart';
import '../../../../../components/custom_dropdown/custom_dropdown.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(appLocalization(context).settings),
        ),
        centerTitle: false,
        bottom: const PreferredSize(preferredSize: Size.zero, child: Divider()),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.plus_rectangle)),
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.bars)),
        ],
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

                  /// change language with segmented control
                  Row(
                    children: [
                      Text(appLocalization(context).changeLanguage),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: CupertinoSlidingSegmentedControl<ThemeMode>(
                          groupValue: controller.themeMode.value,
                          children: {
                            ThemeMode.light: createSegment(context, appLocalization(context).lightMode),
                            ThemeMode.dark: createSegment(context, appLocalization(context).darkMode),
                          },
                          onValueChanged: (value) => controller.changeTheme(value),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// change theme with dropdown
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
