import 'dart:convert';
import 'dart:io';
import 'package:catstagram/core/exceptions/custom_http_exception.dart';
import 'package:catstagram/core/extensions/string_map_prettier.dart';
import 'package:catstagram/core/logger.dart';
import 'package:catstagram/core/services/network_service/http_enums.dart';
import 'package:catstagram/core/services/network_service/http_urls.dart';
import 'package:http/http.dart' as http;

part 'http_header.dart';
part 'http_requests.dart';

class HttpClient with HttpRequests, Header {
  HttpClient._();
  static final HttpClient instance = HttpClient._();

  Future<http.Response?> request({
    required HttpMethods method,
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Object? body,
    bool encode = false,
    bool retry = true,
    bool isAuth = false,
  }) async {
    if (isAuth) {
      headers = headers ?? {};
      final headerAuth = createHeader();
      headers.addAll(headerAuth);
    }

    final uri = Uri(
      scheme: 'https',
      host: HttpUrls.catUrl,
      path: path,
      queryParameters: queryParameters,
    );

    Log.info(
      '\ntype: ${method.name}',
      '\npath: $uri',
      '\nheader: ${headers.prettify()}',
      body != null ? '\nbody: $body' : '',
      queryParameters != null ? '\nqueryParameters: $queryParameters' : '',
    );

    http.Response? response;

    try {
      switch (method) {
        case HttpMethods.GET:
          response = await _get(uri, headers);
        case HttpMethods.POST:
          response = await _post(uri, headers, body, encode);
        case HttpMethods.PUT:
          response = await _put(uri, headers, body, encode);
        case HttpMethods.PATCH:
          response = await _patch(uri, headers, body, encode);
        case HttpMethods.DELETE:
          response = await _delete(uri, headers, body, encode);
      }
    } catch (e, s) {
      Log.error('$e\nUrl: $uri\nMethod: $method \n sTack: $s');
      if (e is SocketException) {
        final isNetwork = (await http.get(Uri.parse('http://google.com'))).body.isNotEmpty;

        if (!isNetwork) {
          throw CustomHttpException(statusCode: 999, message: 'No internet connection!');
        } else {
          throw CustomHttpException(statusCode: 998, message: 'Server error!');
        }
      } else {
        throw CustomHttpException(statusCode: 997, message: 'Unknown error!');
      }
    }

    if (response.statusCode >= 500) {
      throw CustomHttpException(statusCode: 998, message: 'Server error!');
    }

// NOT throw error if status codes not success
    if (!(response.statusCode >= 200 && response.statusCode < 300)) {
      // TODO when server exception style is ready, create model for errors
      throw CustomHttpException(statusCode: response.statusCode, message: response.body);
    }

    Log.success('Status Code:', response.statusCode);
    return response;
  }
}
