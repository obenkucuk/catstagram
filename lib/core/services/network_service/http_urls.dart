import '../../config/app_config.dart';

class HttpUrls {
  static final String catUrl = AppConfig.instance.catUrl;
  static final String pexelUrl = AppConfig.instance.pexelUrl;

  static const String tags = 'api/tags';
  static const String catsFromTag = 'api/cats';

  static const String pexelsSearch = 'videos/search';
}
