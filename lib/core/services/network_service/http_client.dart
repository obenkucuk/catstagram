import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../logger.dart';
import '/core/extensions/string_map_prettier.dart';
import '../../exceptions/custom_http_exception.dart';
import 'http_enums.dart';
import 'http_urls.dart';
import 'package:catstagram/core/config/app_config.dart';
part 'http_requests.dart';
part 'http_header.dart';

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
    bool isPexel = false,
    bool isAuth = false,
  }) async {
    if (isAuth) {
      headers = headers ?? {};
      var headerAuth = createHeader();
      headers.addAll(headerAuth);
    }

    var uri = Uri(
      scheme: 'https',
      host: isPexel ? HttpUrls.pexelUrl : HttpUrls.catUrl,
      path: path,
      queryParameters: queryParameters,
    );
    Log.info('\ntype: ${method.name}', '\npath: ${uri.toString()}', '\nheader: ${headers.prettify()}',
        body != null ? '\nbody: $body' : '', queryParameters != null ? '\nqueryParameters: $queryParameters' : '');

    http.Response? response;

    try {
      switch (method) {
        case HttpMethods.GET:
          response = await _get(uri, headers);
          break;
        case HttpMethods.POST:
          response = await _post(uri, headers, body, encode);
          break;
        case HttpMethods.PUT:
          response = await _put(uri, headers, body, encode);
          break;
        case HttpMethods.PATCH:
          response = await _patch(uri, headers, body, encode);
          break;
        case HttpMethods.DELETE:
          response = await _delete(uri, headers, body, encode);
          break;
      }
    } catch (e, s) {
      Log.error('$e\nUrl: $uri\nMethod: $method \n sTack: $s');
      if (e is SocketException) {
        var isNetwork = (await http.get(Uri.parse('http://google.com'))).body.isNotEmpty;

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
      //TODO when server exception style is ready, create model for errors
      throw CustomHttpException(statusCode: response.statusCode, message: response.body);
    }

    Log.success('Status Code:', response.statusCode);
    return response;
  }
}
