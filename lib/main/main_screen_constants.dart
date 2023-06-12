import 'package:catstagram/ui/screens/main_screens/settings_screen/settings_screen.dart';
import 'package:catstagram/ui/screens/main_screens/share_screen/share_screen.dart';
import 'package:flutter/material.dart';

import '../ui/screens/main_screens/home_screen/home_screen.dart';
import '../ui/screens/main_screens/search_screen/search_screen.dart';
import 'my_bottom_bar_models.dart';

final MyBottomBar appBottomBarItems = MyBottomBar(
  [
    const MyBottomBarElemet(
      child: HomeScreen(),
      iconData: Icons.home,
      label: 'Home',
    ),
    const MyBottomBarElemet(
      child: SearchScreen(),
      iconData: Icons.search,
      label: 'Search',
    ),
    const MyBottomBarElemet(
      child: ShareScreen(),
      iconData: Icons.add_box_outlined,
      label: 'Share',
    ),
    const MyBottomBarElemet(
      child: SettingsScreen(),
      iconData: Icons.settings,
      label: 'Settings',
    ),
  ],
);
