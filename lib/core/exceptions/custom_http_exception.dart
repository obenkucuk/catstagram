import '../logger.dart';

class CustomHttpException implements Exception {
  final String message;
  final int statusCode;

  CustomHttpException({required this.statusCode, required this.message}) {
    Log.error(
      'Custom HTTP Exception! Status Code: $statusCode Error Message: $message',
    );
  }
}
