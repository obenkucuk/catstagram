import 'package:catstagram/core/router/route_names.dart';
import 'package:catstagram/core/router/transition_pages/fade_transition_page.dart';
import 'package:catstagram/core/router/transition_pages/slide_up_transition_page.dart';
import 'package:catstagram/core/services/router_service/router_argsuments_model.dart';
import 'package:catstagram/core/services/router_service/router_enums.dart';
import 'package:catstagram/main/main_screen.dart';
import 'package:catstagram/ui/screens/main_screens/home_screen/controller/home_controller.dart';
import 'package:catstagram/ui/screens/other_screens/splash_screen/splash_screen.dart';
import 'package:catstagram/ui/screens/other_screens/story_screen/story_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: RoutesNames.splash,
      pageBuilder: (context, state) => _routerPageBuilder(
        state,
        context,
        const SplashScreen(),
      ),
    ),
    GoRoute(
      path: '/main',
      name: RoutesNames.main,
      pageBuilder: (context, state) => _routerPageBuilder(
        state,
        context,
        const MainScreen(),
      ),
    ),
    GoRoute(
      path: '/story',
      name: RoutesNames.story,
      pageBuilder: (context, state) => _routerPageBuilder<StoryScreenRouterModel>(
        state,
        context,
        StoryScreen(
          elements: (state.extra as RouterArgumentsModel<StoryScreenRouterModel>).extra!.models,
          initialPeopleIndex: (state.extra as RouterArgumentsModel<StoryScreenRouterModel>).extra!.index,
        ),
      ),
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

Page<T> _routerPageBuilder<T>(GoRouterState state, BuildContext context, Widget child) {
  final routerArguments = (state.extra ?? RouterArgumentsModel<T>()) as RouterArgumentsModel<T>;

  switch (routerArguments.appPageTransition) {
    case AppPageTransition.custom:
      return MaterialPage(child: child);

    case AppPageTransition.slideUp:
      return SlideUpTransitionPage(state, child: child);

    case AppPageTransition.fade:
      return FadeTransitionPage(state, child: child);
  }
}
