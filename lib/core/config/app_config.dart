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
    _baseUrl = dotenv.env['BASE_URL'] ?? 'base_url';
    _appName = dotenv.env['APP_NAME'] ?? 'app_name';

    Log.info('AppConfig initialized successfully');
  }

  String get baseUrl => _baseUrl;
  static late final String _baseUrl;

  String get appName => _appName;
  late final String _appName;
}
