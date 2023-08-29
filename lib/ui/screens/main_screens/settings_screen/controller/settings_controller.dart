// ignore_for_file: use_build_context_synchronously

import 'package:catstagram/c_dropdown/c_dropdown_item.dart';
import 'package:catstagram/constants/app_enums.dart';
import 'package:catstagram/constants/loading_status_enums.dart';
import 'package:catstagram/core/services/localization_service/localization_service.dart';
import 'package:catstagram/core/services/theme_service/theme_service.dart';
import 'package:catstagram/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final GlobalKey overlayKey1 = GlobalKey();
  final GlobalKey overlayKey2 = GlobalKey();
  final scaffoldKey = GlobalKey();
  late final Rx<ThemeMode> themeMode = Rx(ThemeService.instance.getThemeMode(context));
  final Rx<LoadingStatus> loadingStatus = LoadingStatus.init.obs;

  BuildContext get context => scaffoldKey.currentContext!;
  final Rx<Locale> locale = Rx(const Locale('en'));

  /// change theme function
  Future<void> changeTheme(ThemeMode? value) async {
    themeMode.value = value!;
    await ThemeService.instance
        .changeThemeMode(context, mode: value == ThemeMode.dark ? ThemeMode.dark : ThemeMode.light);
  }

  /// change language function
  Future<void> changeLocalization(int index) async {
    await LocalizationService.instance.changeLocal(context, locale: index == 0 ? AppLocales.tr : AppLocales.en);
  }

  /// creates dropdown items for the language dropdown
  Future<void> _initLocale() async {
    final localeFromStorage = await LocalizationService.instance.getCurrentLocale();
    locale.value = localeFromStorage;

    itemsU.value = {
      'dd': CustomDropdownExampleItem(child: Text('dd üst', style: s14W700(context))),
      'dodo': CustomDropdownExampleItem(child: Text('dodo üst', style: s14W700(context))),
      'oben': CustomDropdownExampleItem(child: Text('oben üst' * 5, style: s14W700(context))),
      'batu': CustomDropdownExampleItem(child: Text('batu üst', style: s14W700(context))),
      'zara': CustomDropdownExampleItem(child: Text('zara üst', style: s14W700(context))),
    };

    itemsA.value = {
      'dd': CustomDropdownExampleItem(child: Text('dd alk', style: s14W700(context))),
      'dodo': CustomDropdownExampleItem(child: Text('dodo alt', style: s14W700(context))),
      'oben': CustomDropdownExampleItem(child: Text('oben alt' * 5, style: s14W700(context))),
      'batu': CustomDropdownExampleItem(child: Text('batu alt', style: s14W700(context))),
      'zara': CustomDropdownExampleItem(child: Text('zara alt', style: s14W700(context))),
    };
  }

  /// to wait some functions to complete before the screen loads
  Future<void> _ready() async {
    try {
      loadingStatus.value = LoadingStatus.loading;
      await Future.wait([_initLocale()]);
      loadingStatus.value = LoadingStatus.loaded;
    } catch (e) {
      loadingStatus.value = LoadingStatus.error;
    } finally {}
  }

  @override
  void onReady() {
    super.onReady();
    _ready();
  }

  @override
  void onInit() {
    super.onInit();
  }

  final RxMap<String, Widget> itemsU = <String, Widget>{}.obs;
  final RxMap<String, Widget> itemsA = <String, Widget>{}.obs;
}
