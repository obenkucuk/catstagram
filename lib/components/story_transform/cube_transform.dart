import 'dart:math' as math;
import 'package:flutter/material.dart';

@immutable
final class CubeTransformWidget extends StatelessWidget {
  const CubeTransformWidget({
    required this.index,
    required this.currentPage,
    required this.pageDelta,
    required this.child,
    super.key,
    this.perspectiveScale = 0.0005,
    this.rotationAngle = 90,
  });

  final double perspectiveScale;
  final AlignmentGeometry rightPageAlignment = Alignment.centerLeft;
  final AlignmentGeometry leftPageAlignment = Alignment.centerRight;
  final double rotationAngle;
  final int index;
  final int currentPage;
  final double pageDelta;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (index == currentPage) {
      return Transform(
        alignment: leftPageAlignment,
        transform: Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateY((math.pi / 180 * rotationAngle) * pageDelta),
        child: child,
      );
    } else if (index == currentPage + 1) {
      return Transform(
        alignment: rightPageAlignment,
        transform: Matrix4.identity()
          ..setEntry(3, 2, perspectiveScale)
          ..rotateY(-(math.pi / 180 * rotationAngle) * (1 - pageDelta)),
        child: child,
      );
    } else {
      return child;
    }
  }
}
