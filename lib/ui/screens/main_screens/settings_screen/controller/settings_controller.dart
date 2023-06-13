import 'package:catstagram/constants/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/services/localization_service/localization_service.dart';
import '../../../../../core/services/theme_service/theme_service.dart';

class SettingsController extends GetxController {
  final scaffoldKey = GlobalKey();
  late final Rx<ThemeMode> themeMode = Rx(ThemeService.instance.getThemeMode(context));
  final Rx<LoadingStatus> loadingStatus = LoadingStatus.init.obs;

  late final Map<String, Widget> dropdownItems;

  BuildContext get context => scaffoldKey.currentContext!;

  Future<void> changeTheme(ThemeMode? value) async {
    themeMode.value = value!;
    await ThemeService.instance
        .changeThemeMode(context, mode: value == ThemeMode.dark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> changeLocalization(int index) async {
    await LocalizationService.instance.changeLocal(context, locale: index == 0 ? AppLocales.tr : AppLocales.en);
  }

  final Rx<Locale> locale = Rx(const Locale('en'));

  Future<void> _initLocale() async {
    await Future.microtask(() {
      dropdownItems = {
        appLocalization(context).turkish: Text(appLocalization(context).turkish),
        appLocalization(context).english: Text(appLocalization(context).english)
      };
    });

    var localeFromStorage = await LocalizationService.instance.getCurrentLocale();
    locale.value = localeFromStorage;
  }

  Future _ready() async {
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
}

///TODO:
enum LoadingStatus { init, loading, loaded, error }
