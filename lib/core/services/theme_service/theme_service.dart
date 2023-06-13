import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../theme/material_inherited.dart';
import '../../logger.dart';
import '../storage_service/storage_service.dart';

class ThemeService {
  ThemeService._();
  static final ThemeService instance = ThemeService._();

  Future<void> init() async {
    var currentPrefs = await StorageService.instance.getUserPreferences();

    initThemeMode = currentPrefs.themeMode;

    Log.info('ThemeService initialized successfully');
  }

  ThemeMode initThemeMode = ThemeMode.system;

  ThemeMode getThemeMode(context) => MaterialAppInheritedWidget.of(context).themeMode;

  Future<void> changeThemeMode(BuildContext context, {required ThemeMode mode}) async {
    MaterialAppInheritedWidget.of(context).changeTheme(
      mode: mode,
      brightness: mode != ThemeMode.system
          ? (mode == ThemeMode.dark ? Brightness.dark : Brightness.light)
          : PlatformDispatcher.instance.platformBrightness,
    );

    var currentPrefs = await StorageService.instance.getUserPreferences();

    await StorageService.instance.saveUserPreferences(
      currentPrefs.copyWith(themeMode: mode),
    );
  }
}
