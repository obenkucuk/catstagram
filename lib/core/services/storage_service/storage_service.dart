import 'dart:async';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../logger.dart';
import '../localization_service/localization_service.dart';
import 'models/user_preferences_model.dart';

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
      var locale = LocalizationService.instance.getSysyemLocale();

      preferences = IsarUserPreferencesModel(
        locale: locale.languageCode,
        themeMode: ThemeMode.system,
        isSystemLocale: true,
      );
    }

//if preferences found but locale is not supported use default locale
    if (preferences.isSystemLocale) {
      var locale = LocalizationService.instance.getSysyemLocale();

      preferences = preferences.copyWith(locale: locale.languageCode);
    }

    return preferences;
  }

  Future<void> cleanDb() async {
    final isar = await isarDb;
    await isar.writeTxn(() => isar.clear());
  }

  Future<Isar> openIsarDB() async {
    var dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [
          IsarUserPreferencesModelSchema,
        ],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }
}
