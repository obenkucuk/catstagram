import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

@immutable
final class FadeTransitionPage<T> extends CustomTransitionPage<T> {
  FadeTransitionPage({
    required this.state,
    required super.child,
  }) : super(
          key: state.pageKey,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );

  final GoRouterState state;
}
