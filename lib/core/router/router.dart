import 'package:catstagram/core/router/route_names.dart';
import 'package:catstagram/core/router/transition_pages/fade_transition_page.dart';
import 'package:catstagram/core/router/transition_pages/slide_up_transition_page.dart';
import 'package:catstagram/core/services/router_service/router_service.dart';
import 'package:catstagram/main/main_screen.dart';
import 'package:catstagram/ui/screens/main_screens/home_screen/controller/home_controller.dart';
import 'package:catstagram/ui/screens/other_screens/splash_screen/splash_screen.dart';
import 'package:catstagram/ui/screens/other_screens/story_screen/story_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class AppRouter {
  const AppRouter._();
  static final navigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter appRouter = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: RoutesNames.splash,
        pageBuilder: (context, state) => routerPageBuilder(
          context,
          state,
          TransitionTypes.slideUp,
          const SplashScreen(),
        ),
      ),
      GoRoute(
        path: '/main',
        name: RoutesNames.main,
        pageBuilder: (context, state) => routerPageBuilder(
          context,
          state,
          TransitionTypes.slideUp,
          const MainScreen(),
        ),
      ),
      GoRoute(
        path: '/story',
        name: RoutesNames.story,
        pageBuilder: (context, state) {
          final arguments = state.extra as StoryScreenRouterModel;

          return routerPageBuilder<StoryScreenRouterModel>(
            context,
            state,
            TransitionTypes.fade,
            StoryScreen(
              elements: arguments.models,
              initialPeopleIndex: arguments.index,
            ),
          );
        },
      ),
    ],
    errorPageBuilder: (context, state) {
      return const MaterialPage(child: Scaffold(body: Center(child: Text('Error Page will be here'))));
    },
    redirect: (BuildContext context, GoRouterState state) {
      /// TODO redirect if user is not logged in

      return null;
    },
  );

  static Page<T> routerPageBuilder<T>(
    BuildContext context,
    GoRouterState state,
    TransitionTypes type,
    Widget child,
  ) {
    switch (type) {
      case TransitionTypes.custom:
        return MaterialPage<T>(child: child);

      case TransitionTypes.slideUp:
        return SlideUpTransitionPage<T>(state: state, child: child);

      case TransitionTypes.fade:
        return FadeTransitionPage<T>(state: state, child: child);
    }
  }
}
