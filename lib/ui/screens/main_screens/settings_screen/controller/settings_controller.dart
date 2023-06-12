import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../../../../core/services/localization_service/localization_service.dart';
import '../../../../../core/services/theme_service/theme_service.dart';

class SettingsController extends GetxController {
  final scaffoldKey = GlobalKey();
  BuildContext get context => scaffoldKey.currentContext!;

  final Rx<Brightness> brigthtness = Rx(SchedulerBinding.instance.window.platformBrightness);

  Future<void> changeTheme(Brightness? value) async {
    brigthtness.value = value!;
    ThemeService.instance.changeThemeMode(context, mode: value == Brightness.dark ? ThemeMode.dark : ThemeMode.light);

    var locale = await LocalizationService.instance.getCurrentLocale();
  }
}
