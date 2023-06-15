import 'package:catstagram/core/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logger.dart';
import '../../models/story_model.dart';
import '../localization_service/localization_service.dart';
import '../storage_service/storage_service.dart';
import '../theme_service/theme_service.dart';

class SessionService {
  SessionService._();
  static final SessionService instance = SessionService._();

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await AppConfig.instance.init();
    await StorageService.instance.init();
    await ThemeService.instance.init();
    await LocalizationService.instance.init();

    Log.info('SessionService initialized successfully');
  }

  List<String> allTags = [];
  final RxList<StoryModel> dataStories = <StoryModel>[].obs;
}
