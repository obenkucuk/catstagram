import 'package:flutter/material.dart';

///default page controller has no smooth scroll functionality. So, we need to create a [SmoothPageController].
class SmoothPageController extends PageController {
  int length;
  int? index;

  SmoothPageController({
    int initialPage = 0,
    bool keepPage = true,
    double viewportFraction = 1.0,
    required this.length,
  }) : super(
          initialPage: initialPage,
          keepPage: keepPage,
          viewportFraction: viewportFraction,
        );
//smooth scroll to the next page without animation.
  smoothNext() {
    return page != null
        ? animateToPage(page!.round() + 1, duration: const Duration(microseconds: 1), curve: Curves.bounceIn)
        : null;
  }

//smooth scroll to the previous page without animation.
  smoothPrevious() {
    return page != null
        ? animateToPage(page!.round() - 1, duration: const Duration(microseconds: 1), curve: Curves.bounceIn)
        : null;
  }
}
