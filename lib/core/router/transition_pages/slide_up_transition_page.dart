import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideUpTransitionPage<T> extends CustomTransitionPage<T> {
  SlideUpTransitionPage(
    this.state, {
    required super.child,
  }) : super(
          key: state.pageKey,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(
                Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ),
              ),
              child: child,
            );
          },
        );

  final GoRouterState state;
}
