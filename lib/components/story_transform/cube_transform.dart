import 'dart:math' as math;
import 'package:flutter/material.dart';

@immutable
class CubeTransformWidget extends StatelessWidget {
  CubeTransformWidget({
    super.key,
    this.rotationAngle = 90,
    required this.index,
    this.currentPage,
    required this.pageDelta,
    required this.itemCount,
    required this.child,
  }) {
    rotationAngle = math.pi / 180 * rotationAngle;
  }

  final double perspectiveScale = 0.0005;
  final AlignmentGeometry rightPageAlignment = Alignment.centerLeft;
  final AlignmentGeometry leftPageAlignment = Alignment.centerRight;
  double rotationAngle;

  final int index;
  final int? currentPage;
  final double pageDelta;
  final int itemCount;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (index == currentPage) {
      return Transform(
        alignment: leftPageAlignment,
        transform: Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateY(rotationAngle * pageDelta),
        child: child,
      );
    } else if (index == currentPage! + 1) {
      return Transform(
        alignment: rightPageAlignment,
        transform: Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateY(-rotationAngle * (1 - pageDelta)),
        child: child,
      );
    } else {
      return child;
    }
  }
}
