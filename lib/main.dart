import 'dart:developer';
import 'dart:ui';

import 'package:catstagram/core/config/app_config.dart';
import 'package:catstagram/core/router/router.dart';
import 'package:catstagram/core/services/session_service/session_service.dart';
import 'package:catstagram/main/main_screen_constants.dart';
import 'package:catstagram/theme/material_inherited.dart';
import 'package:catstagram/theme/theme_data_dark.dart';
import 'package:catstagram/theme/theme_data_light.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  await SessionService.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialAppUpdater(
      myBottomBar: appBottomBarItems,
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            title: AppConfig.instance.appName,
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: MaterialAppInheritedWidget.of(context).themeMode,
            locale: MaterialAppInheritedWidget.of(context).locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            routerConfig: AppRouter.appRouter,
          );
        },
      ),
    );
  }
}

///[MyMediaQuery] is a class that contains all the information about the screen size, padding, etc.
class MyMediaQuery {
  static late double width;
  static late double height;
  static late EdgeInsets padding;
  static late MediaQueryData _mediaQueryData;
  static late Brightness platformBrightness;
  static late Orientation orientation;
  static late List<DisplayFeature> displayFeatures;
  static late double textScaleFactor;

  static void setScreenSize(BuildContext context) {
    _mediaQueryData = MediaQueryData.fromView(View.of(context));

    height = _mediaQueryData.size.height;
    width = _mediaQueryData.size.width;
    padding = _mediaQueryData.padding;
    platformBrightness = _mediaQueryData.platformBrightness;
    orientation = _mediaQueryData.orientation;
    displayFeatures = _mediaQueryData.displayFeatures;
    textScaleFactor = _mediaQueryData.textScaleFactor;

    log('$width x $height', name: 'Screen local pixel');
  }
}
