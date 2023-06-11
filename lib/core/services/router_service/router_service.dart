import 'package:go_router/go_router.dart';
import '../../router/router.dart';
import 'router_argsuments_model.dart';

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
