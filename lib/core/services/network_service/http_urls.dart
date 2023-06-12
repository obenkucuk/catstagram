import '../../config/app_config.dart';

class HttpUrls {
  static final String baseUrl = AppConfig.instance.baseUrl;

  static const String tags = 'api/tags';

  static const String catsFromTag = 'api/cats';
}
