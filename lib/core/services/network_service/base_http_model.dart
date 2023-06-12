import '../../exceptions/custom_http_exception.dart';

class BaseHttpModel<T> {
  T data;
  CustomHttpException? error;

  BaseHttpModel({
    this.error,
    required this.data,
  });
}
