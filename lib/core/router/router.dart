import 'package:catstagram/ui/screens/other_screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/router_service/router_argsuments_model.dart';
import '../../main/main_screen.dart';
import '../services/router_service/router_enums.dart';
import 'route_names.dart';
import 'transition_pages/fade_transition_page.dart';
import 'transition_pages/slide_up_transition_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: RoutesNames.splash,
      pageBuilder: (context, state) => _routerPageBuilder(state, context, const SplashScreen()),
    ),
    GoRoute(
      path: '/main',
      name: RoutesNames.main,
      pageBuilder: (context, state) => _routerPageBuilder(state, context, const MainScreen()),
    ),
  ],
  errorPageBuilder: (context, state) {
    return const MaterialPage(child: Scaffold(body: Center(child: Text('Error Page will be here'))));
  },
  redirect: (BuildContext context, GoRouterState state) {
    //TODO redirect if user is not logged in
    return null;
  },
);

Page _routerPageBuilder(GoRouterState state, BuildContext context, Widget child) {
  final RouterArgumentsModel routerArguments = (state.extra ?? RouterArgumentsModel()) as RouterArgumentsModel;

  switch (routerArguments.appPageTransition) {
    case AppPageTransition.custom:
      return MaterialPage(child: child);

    case AppPageTransition.slideUp:
      return SlideUpTransitionPage(state, child: child);

    case AppPageTransition.fade:
      return FadeTransitionPage(state, child: child);
  }
}
