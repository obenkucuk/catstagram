import 'package:flutter/material.dart';
import 'core/router/router.dart';
import 'core/services/session_service/session_service.dart';
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
    //NOT bottom bar items must be initialized before MaterialAppUpdater

    return MaterialAppUpdater(
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
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