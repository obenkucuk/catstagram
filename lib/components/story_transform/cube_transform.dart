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
  });

  final int index;
  final int currentPage;
  final double pageDelta;
  final Widget child;

  AlignmentGeometry get rightPageAlignment => Alignment.centerLeft;
  AlignmentGeometry get leftPageAlignment => Alignment.centerRight;

  @override
  Widget build(BuildContext context) {
    if (index == currentPage) {
      return Transform(
        alignment: leftPageAlignment,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0005)
          ..rotateY((math.pi / 180 * 90) * pageDelta),
        child: child,
      );
    } else if (index == currentPage + 1) {
      return Transform(
        alignment: rightPageAlignment,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0005)
          ..rotateY(-(math.pi / 180 * 90) * (1 - pageDelta)),
        child: child,
      );
    } else {
      return child;
    }
  }
}
