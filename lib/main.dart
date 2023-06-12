import 'package:catstagram/core/config/app_config.dart';
import 'package:flutter/material.dart';
import 'core/router/router.dart';
import 'core/services/session_service/session_service.dart';
import 'main/main_screen_constants.dart';
import 'theme/material_inherited.dart';
import 'theme/theme_data_dark.dart';
import 'theme/theme_data_light.dart';
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
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
