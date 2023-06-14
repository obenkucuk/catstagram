import 'package:flutter/material.dart';

class SmoothPageController extends PageController {
  int? length;
  int? index;

  SmoothPageController({
    int initialPage = 0,
    bool keepPage = true,
    double viewportFraction = 1.0,
    this.length,
  }) : super(
          initialPage: initialPage,
          keepPage: keepPage,
          viewportFraction: viewportFraction,
        );

  smoothNext() {
    return animateToPage(page!.round() + 1, duration: const Duration(microseconds: 1), curve: Curves.bounceIn);
  }

  smoothPrevious() {
    return animateToPage(page!.round() - 1, duration: const Duration(microseconds: 1), curve: Curves.bounceIn);
  }
}
