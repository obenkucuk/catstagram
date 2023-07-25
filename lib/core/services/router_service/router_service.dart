import 'package:catstagram/core/router/router.dart';
import 'package:go_router/go_router.dart';

enum TransitionTypes { custom, slideUp, fade }

final class RouterService {
  const RouterService._();

  static Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    T? args,
  }) async {
    final router = await AppRouter.navigatorKey.currentContext!.pushNamed<T>(
      routeName,
      extra: args,
    );

    return router;
  }

  static void replaceNamed<T extends Object?>(
    String routeName, {
    T? args,
  }) {
    return AppRouter.navigatorKey.currentContext!.replaceNamed(
      routeName,
      extra: args,
    );
  }
}
