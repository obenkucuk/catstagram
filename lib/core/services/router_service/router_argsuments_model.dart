import 'package:catstagram/core/services/router_service/router_enums.dart';

class RouterArgumentsModel<T> {
  RouterArgumentsModel({
    this.appPageTransition = AppPageTransition.custom,
    this.extra,
  });

  final AppPageTransition appPageTransition;
  final T? extra;
}
