import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../logger.dart';

class AppConfig {
  AppConfig._();
  static final AppConfig instance = AppConfig._();

  Future<void> init() async {
    //load .env file
    if (kDebugMode) {
      await dotenv.load(fileName: '.env.development');
    } else {
      await dotenv.load(fileName: '.env.production');
    }

    //set variables
    _pexelUrl = dotenv.env['PEXEL_URL'] ?? 'pexel_url';
    _catUrl = dotenv.env['CAT_URL'] ?? 'cat_url';
    _appName = dotenv.env['APP_NAME'] ?? 'app_name';
    _pexelToken = dotenv.env['PEXEL_TOKEN'] ?? 'pexel_token';

    Log.info('AppConfig initialized successfully');
  }

  String get pexelToken => _pexelToken;
  static late final String _pexelToken;

  String get pexelUrl => _pexelUrl;
  static late final String _pexelUrl;

  String get catUrl => _catUrl;
  static late final String _catUrl;

  String get appName => _appName;
  late final String _appName;
}
