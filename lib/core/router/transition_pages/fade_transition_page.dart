import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

@immutable
final class FadeTransitionPage extends CustomTransitionPage {
  final GoRouterState state;
  FadeTransitionPage(
    this.state, {
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
}
