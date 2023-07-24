import 'package:flutter/material.dart';

class MyBottomBar {
  MyBottomBar(this.elements);

  final List<MyBottomBarElemet> elements;
}

class MyBottomBarElemet {
  const MyBottomBarElemet({
    required this.child,
    required this.iconData,
    required this.label,
  });
  final IconData iconData;
  final String label;
  final Widget child;
}
