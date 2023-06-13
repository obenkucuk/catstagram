import '../../exceptions/custom_http_exception.dart';

class BaseHttpModel<T> {
  T data;
  int statusCode;
  CustomHttpException? error;

  BaseHttpModel({this.error, required this.data, required this.statusCode});
}
