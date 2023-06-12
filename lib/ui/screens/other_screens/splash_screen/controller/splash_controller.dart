import 'package:get/get.dart';
import '../../../../../core/router/route_names.dart';
import '../../../../../core/services/router_service/router_argsuments_model.dart';
import '../../../../../core/services/router_service/router_enums.dart';
import '../../../../../core/services/router_service/router_service.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();

    /// Üç saniye beklettikten sonra main page'a yönlendirir.
    await Future.delayed(
      const Duration(milliseconds: 3000),
      () => RouterService.instance.replaceNamed(RoutesNames.main,
          args: RouterArgumentsModel(
            appPageTransition: AppPageTransition.fade,
          )),
    );
  }
}
