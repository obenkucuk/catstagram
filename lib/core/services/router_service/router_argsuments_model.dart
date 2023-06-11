import 'router_enums.dart';

class RouterArgumentsModel<T> {
  final AppPageTransition appPageTransition;
  final T? extra;

  RouterArgumentsModel({
    this.appPageTransition = AppPageTransition.custom,
    this.extra,
  });
}
