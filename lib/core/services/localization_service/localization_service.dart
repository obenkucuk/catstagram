import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_enums.dart';
import '../../../theme/material_inherited.dart';
import '../../logger.dart';
import '../storage_service/storage_service.dart';
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

    bool isSysLocalSupported =
        AppLocalizations.supportedLocales.map((e) => e.languageCode).contains(locale.languageCode);

    if (!isSysLocalSupported) {
      locale = AppConstants.defoultLocale;
    }

    return locale;
  }

  Future<void> changeLocal(BuildContext context, {required AppLocales locale}) async {
    MaterialAppInheritedWidget.of(context).changeLocale(locale);

    var current = await StorageService.instance.getUserPreferences();

    await StorageService.instance.saveUserPreferences(
      current.copyWith(locale: locale.name, isSystemLocale: locale == AppLocales.system),
    );
  }
}

/// NOT: App Localization
AppLocalizations appLocalization(BuildContext context) => AppLocalizations.of(context);
