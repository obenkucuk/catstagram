import 'package:catstagram/constants/app_enums.dart';
import 'package:catstagram/core/services/localization_service/localization_service.dart' show LocalizationService;
import 'package:catstagram/core/services/theme_service/theme_service.dart' show ThemeService;
import 'package:catstagram/main/main_screen.dart';
import 'package:catstagram/main/my_bottom_bar_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///for change material app theme mode and locale or app level changes
class MaterialAppUpdater extends StatefulWidget {
  const MaterialAppUpdater({
    required this.child,
    super.key,
    this.myBottomBar,
  });
  
  final Widget child;
  final MyBottomBar? myBottomBar;

  @override
  State<MaterialAppUpdater> createState() => MaterialAppUpdaterState();
}

class MaterialAppUpdaterState extends State<MaterialAppUpdater> {
  ThemeMode themeMode = ThemeService.instance.initThemeMode;
  Locale locale = LocalizationService.instance.initLocale;

  void changeTheme({required ThemeMode mode, Brightness? brightness}) {
    setState(() {
      themeMode = mode;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarBrightness: brightness));
    });
  }

  void changeLocale(AppLocales selectedLocale) {
    setState(() {
      if (selectedLocale == AppLocales.system) {
        locale = LocalizationService.instance.getSysyemLocale();
      } else {
        locale = Locale(selectedLocale.name);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    MainScreen.myBottomBar = widget.myBottomBar;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialAppInheritedWidget(
      state: this,
      themeMode: themeMode,
      locale: locale,
      child: widget.child,
    );
  }
}

///
class MaterialAppInheritedWidget extends InheritedWidget {
  const MaterialAppInheritedWidget({
    required super.child,
    required this.locale,
    required this.state,
    required this.themeMode,
    super.key,
  });

  final ThemeMode themeMode;
  final Locale locale;
  final MaterialAppUpdaterState state;

  static MaterialAppUpdaterState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MaterialAppInheritedWidget>()!.state;
  }

  @override
  bool updateShouldNotify(covariant MaterialAppInheritedWidget oldWidget) {
    return themeMode != oldWidget.themeMode || locale != oldWidget.locale;
  }
}
