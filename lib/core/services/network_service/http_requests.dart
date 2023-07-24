part of 'http_client.dart';

mixin HttpRequests {
  Future<http.Response> _get(Uri uri, [Map<String, String>? headers]) async {
    final response = await http.get(uri, headers: headers).timeout(
          const Duration(seconds: 10),
          onTimeout: () => http.Response(jsonEncode({'message': 'Timed Out'}), 408),
        );

    return response;
  }

  Future<http.Response> _post(Uri uri, [Map<String, String>? headers, Object? body, bool encode = false]) async {
    final response = await http.post(uri, headers: headers, body: encode ? jsonEncode(body) : body).timeout(
          const Duration(seconds: 10),
          onTimeout: () => http.Response(jsonEncode({'message': 'Timed Out'}), 408),
        );

    return response;
  }

  Future<http.Response> _patch(Uri uri, [Map<String, String>? headers, Object? body, bool encode = false]) async {
    final response = await http.patch(uri, headers: headers, body: encode ? jsonEncode(body) : body).timeout(
          const Duration(seconds: 10),
          onTimeout: () => http.Response(jsonEncode({'message': 'Timed Out'}), 408),
        );

    return response;
  }

  Future<http.Response> _delete(Uri uri, [Map<String, String>? headers, Object? body, bool encode = false]) async {
    final response = await http.delete(uri, headers: headers, body: encode ? jsonEncode(body) : body).timeout(
          const Duration(seconds: 10),
          onTimeout: () => http.Response(jsonEncode({'message': 'Timed Out'}), 408),
        );

    return response;
  }

  Future<http.Response> _put(Uri uri, [Map<String, String>? headers, Object? body, bool encode = false]) async {
    final response = await http.put(uri, headers: headers, body: encode ? jsonEncode(body) : body).timeout(
          const Duration(seconds: 10),
          onTimeout: () => http.Response(jsonEncode({'message': 'Timed Out'}), 408),
        );

    return response;
  }
}
