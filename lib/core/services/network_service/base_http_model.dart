// ignore: always_use_package_imports
import '../../exceptions/custom_http_exception.dart';

class BaseHttpModel<T> {
  BaseHttpModel({required this.data, required this.statusCode, this.error});

  T data;
  int statusCode;
  CustomHttpException? error;
}
