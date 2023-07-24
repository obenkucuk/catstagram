import 'package:catstagram/main/my_bottom_bar_models.dart';
import 'package:catstagram/ui/screens/main_screens/home_screen/home_screen.dart';
import 'package:catstagram/ui/screens/main_screens/search_screen/search_screen.dart';
import 'package:catstagram/ui/screens/main_screens/settings_screen/settings_screen.dart';
import 'package:catstagram/ui/screens/main_screens/share_screen/share_screen.dart';
import 'package:flutter/cupertino.dart';

final MyBottomBar appBottomBarItems = MyBottomBar(
  [
    const MyBottomBarElemet(
      child: HomeScreen(),
      iconData: CupertinoIcons.home,
      label: 'Home',
    ),
    const MyBottomBarElemet(
      child: SearchScreen(),
      iconData: CupertinoIcons.search,
      label: 'Search',
    ),
    const MyBottomBarElemet(
      child: ShareScreen(),
      iconData: CupertinoIcons.plus_app,
      label: 'Share',
    ),
    const MyBottomBarElemet(
      child: SettingsScreen(),
      iconData: CupertinoIcons.settings,
      label: 'Settings',
    ),
  ],
);
