import 'dart:async';
import 'package:catstagram/core/logger.dart' show Log;
import 'package:catstagram/core/services/localization_service/localization_service.dart' show LocalizationService;
import 'package:catstagram/core/services/storage_service/models/user_preferences_model.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;

class StorageService {
  StorageService._();
  static final StorageService instance = StorageService._();

  late final Future<Isar> isarDb;

  Future<void> init() async {
    isarDb = openIsarDB();
    Log.info('StorageService initialized successfully');
  }

  //preferences
  Future<void> saveUserPreferences(IsarUserPreferencesModel preferences) async {
    final isar = await isarDb;

    isar.writeTxnSync<int>(() => isar.isarUserPreferencesModels.putSync(preferences));
  }

  Future<void> deleteUserPreferences() async {
    final isar = await isarDb;

    await isar.writeTxn(() async {
      await isar.isarUserPreferencesModels.clear();
    });
  }

  Future<IsarUserPreferencesModel> getUserPreferences() async {
    final isar = await isarDb;

    IsarUserPreferencesModel? preferences;

    try {
      preferences = await isar.isarUserPreferencesModels.where().findFirst();
    } catch (_) {
      Log.error('User preferences not found');
    }

//if preferences not found use system preferences
//if system locale is not supported use default locale
    if (preferences == null) {
      // get system local
      final locale = LocalizationService.instance.getSysyemLocale();

      preferences = IsarUserPreferencesModel(
        locale: locale.languageCode,
        themeMode: ThemeMode.system,
        isSystemLocale: true,
      );
    }

//if preferences found but locale is not supported use default locale
    if (preferences.isSystemLocale) {
      final locale = LocalizationService.instance.getSysyemLocale();

      preferences = preferences.copyWith(locale: locale.languageCode);
    }

    return preferences;
  }

  Future<void> cleanDb() async {
    final isar = await isarDb;
    await isar.writeTxn(isar.clear);
  }

  Future<Isar> openIsarDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return Isar.open(
        [IsarUserPreferencesModelSchema],
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }
}
