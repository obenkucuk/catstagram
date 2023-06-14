part of 'http_client.dart';

///[Header] mixin is used to create headers for http client
mixin Header {
  Map<String, String> createHeader() {
    String token = AppConfig.instance.pexelToken;

    Map<String, String> header = {
      'Authorization': token,
    };

    return header;
  }
}