import 'package:catstagram/c_dropdown/c_dropdown.dart';
import 'package:catstagram/components/custom_dropdown/custom_dropdown.dart';
import 'package:catstagram/constants/loading_status_enums.dart';
import 'package:catstagram/core/services/localization_service/localization_service.dart';
import 'package:catstagram/theme/text_styles.dart';
import 'package:catstagram/ui/screens/main_screens/settings_screen/controller/settings_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CDropdown(
                    items: controller.itemsU,
                  ),
                  const SizedBox(height: 10),

                  /// change language with segmented control
                  Row(
                    children: [
                      Text(appLocalization(context).changeTheme),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: CupertinoSlidingSegmentedControl<ThemeMode>(
                          groupValue: controller.themeMode.value,
                          children: {
                            ThemeMode.light: createSegment(context, appLocalization(context).lightMode),
                            ThemeMode.dark: createSegment(context, appLocalization(context).darkMode),
                            ThemeMode.system: createSegment(context, appLocalization(context).system),
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
                      Text(appLocalization(context).changeLanguage),
                      const Spacer(),
                      CustomDropdown.fromText(
                        title: controller.locale.value.languageCode == 'tr' ? 0 : 1,
                        dropdownWidth: MediaQuery.of(context).size.width * 0.4,
                        textStyle: s14W400(context),
                        items: {
                          appLocalization(context).turkish: Text(appLocalization(context).turkish),
                          appLocalization(context).english: Text(appLocalization(context).english)
                        },
                        onSelected: (index) => controller.changeLocalization(index),
                        child: const SizedBox(
                          height: 99,
                          width: 11,
                        ),
                      ),
                    ],
                  ),
                  const TextField(),

                  const SizedBox(
                    height: 400,
                  ),
                  CDropdown(
                    items: controller.itemsA,
                  ),
                  CDropdown(
                    items: controller.itemsA,
                  ),
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
