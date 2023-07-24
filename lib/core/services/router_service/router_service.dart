import 'package:catstagram/core/router/router.dart';
import 'package:catstagram/core/services/router_service/router_argsuments_model.dart';
import 'package:go_router/go_router.dart';

class RouterService {
  RouterService._();
  static final RouterService instance = RouterService._();

  Future<T?> pushNamed<T extends Object?>(String routeName, {RouterArgumentsModel? args}) async {
    return navigatorKey.currentContext!.pushNamed(
      routeName,
      extra: args ?? RouterArgumentsModel(),
    );
  }

  void replaceNamed(String routeName, {RouterArgumentsModel? args}) async {
    return navigatorKey.currentContext!.replaceNamed(
      routeName,
      extra: args ?? RouterArgumentsModel(),
    );
  }
}
