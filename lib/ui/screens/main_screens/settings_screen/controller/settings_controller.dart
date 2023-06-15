import 'package:catstagram/constants/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../constants/loading_status_enums.dart';
import '../../../../../core/services/localization_service/localization_service.dart';
import '../../../../../core/services/theme_service/theme_service.dart';

class SettingsController extends GetxController {
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
    var localeFromStorage = await LocalizationService.instance.getCurrentLocale();
    locale.value = localeFromStorage;
  }

  /// to wait some functions to complete before the screen loads
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
