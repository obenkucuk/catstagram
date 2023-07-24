import 'dart:ui';
import 'package:catstagram/constants/app_constants.dart';
import 'package:catstagram/constants/app_enums.dart';
import 'package:catstagram/core/logger.dart';
import 'package:catstagram/core/services/storage_service/storage_service.dart';
import 'package:catstagram/theme/material_inherited.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationService {
  LocalizationService._();
  static final LocalizationService instance = LocalizationService._();

  late Locale initLocale;

  Future<void> init() async {
    initLocale = await getCurrentLocale();

    Log.info('LocalizationService initialized successfully');
  }

  Future<Locale> getCurrentLocale() async {
    return Locale((await StorageService.instance.getUserPreferences()).locale);
  }

  Locale getSysyemLocale() {
    var locale = PlatformDispatcher.instance.locale;

    final isSysLocalSupported =
        AppLocalizations.supportedLocales.map((e) => e.languageCode).contains(locale.languageCode);

    if (!isSysLocalSupported) {
      locale = AppConstants.defoultLocale;
    }

    return locale;
  }

  Future<void> changeLocal(BuildContext context, {required AppLocales locale}) async {
    MaterialAppInheritedWidget.of(context).changeLocale(locale);

    final current = await StorageService.instance.getUserPreferences();

    await StorageService.instance.saveUserPreferences(
      current.copyWith(locale: locale.name, isSystemLocale: locale == AppLocales.system),
    );
  }
}

/// NOT: App Localization
AppLocalizations appLocalization(BuildContext context) => AppLocalizations.of(context);
