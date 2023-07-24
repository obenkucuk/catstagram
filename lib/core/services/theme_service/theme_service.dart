import 'dart:ui';
import 'package:catstagram/core/logger.dart';
import 'package:catstagram/core/services/storage_service/storage_service.dart';
import 'package:catstagram/theme/material_inherited.dart';
import 'package:flutter/material.dart';

final class ThemeService {
  ThemeService._();
  static final ThemeService instance = ThemeService._();

  Future<void> init() async {
    var currentPrefs = await StorageService.instance.getUserPreferences();

    initThemeMode = currentPrefs.themeMode;

    Log.info('ThemeService initialized successfully');
  }

  ThemeMode initThemeMode = ThemeMode.system;

  ThemeMode getThemeMode(BuildContext context) => MaterialAppInheritedWidget.of(context).themeMode;

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
