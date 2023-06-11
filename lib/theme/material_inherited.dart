import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_enums.dart';
import '../core/services/localization_service/localization_service.dart';
import '../core/services/theme_service/theme_service.dart';
import '../main/main_screen.dart';
import '../main/my_bottom_bar_models.dart';

///for change material app theme mode and locale or app level changes
class MaterialAppUpdater extends StatefulWidget {
  final Widget child;
  final MyBottomBar? myBottomBar;
  const MaterialAppUpdater({
    super.key,
    required this.child,
    this.myBottomBar,
  });

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
  final ThemeMode themeMode;
  final Locale locale;
  final MaterialAppUpdaterState state;

  const MaterialAppInheritedWidget({
    super.key,
    required super.child,
    required this.locale,
    required this.state,
    required this.themeMode,
  });

  static MaterialAppUpdaterState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MaterialAppInheritedWidget>()!.state;
  }

  @override
  bool updateShouldNotify(covariant MaterialAppInheritedWidget oldWidget) {
    return themeMode != oldWidget.themeMode || locale != oldWidget.locale;
  }
}
