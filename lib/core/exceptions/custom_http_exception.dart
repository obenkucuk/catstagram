import 'package:catstagram/core/logger.dart';

class CustomHttpException implements Exception {
  CustomHttpException({required this.statusCode, required this.message}) {
    Log.error('Custom HTTP Exception! Status Code: $statusCode Error Message: $message');
  }

  final String message;
  final int statusCode;
}
