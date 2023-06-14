import 'dart:math' as math;
import 'package:flutter/material.dart';

class CubeTransform {
  final double perspectiveScale = 0.0005;
  final AlignmentGeometry rightPageAlignment = Alignment.centerLeft;
  final AlignmentGeometry leftPageAlignment = Alignment.centerRight;
  final double rotationAngle;

  const CubeTransform({
    double rotationAngle = 90,
  }) : rotationAngle = math.pi / 180 * rotationAngle;

  Widget transform(
    BuildContext context,
    Widget page,
    int index,
    int? currentPage,
    double pageDelta,
    int itemCount,
  ) {
    if (index == currentPage) {
      return Transform(
        alignment: leftPageAlignment,
        transform: Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateY(rotationAngle * pageDelta),
        child: page,
      );
    } else if (index == currentPage! + 1) {
      return Transform(
        alignment: rightPageAlignment,
        transform: Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateY(-rotationAngle * (1 - pageDelta)),
        child: page,
      );
    } else {
      return page;
    }
  }
}
