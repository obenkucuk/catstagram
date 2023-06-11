import 'package:flutter/material.dart';

class MyBottomBar {
  final List<MyBottomBarElemet> elements;

  MyBottomBar(this.elements);
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
