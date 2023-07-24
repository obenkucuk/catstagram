part of 'http_client.dart';

///[Header] mixin is used to create headers for http client
mixin Header {
  Map<String, String> createHeader() {
    const token = '';

    final header = <String, String>{'Authorization': token};

    return header;
  }
}
