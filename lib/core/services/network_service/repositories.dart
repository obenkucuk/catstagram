import 'dart:convert';
import 'package:catstagram/core/logger.dart';
import 'package:catstagram/core/models/cats_from_tag_response_model.dart';
import 'package:catstagram/core/models/tags_response_model.dart';
import 'package:catstagram/core/services/network_service/base_http_model.dart';
import 'package:catstagram/core/services/network_service/http_client.dart';
import 'package:catstagram/core/services/network_service/http_enums.dart';
import 'package:catstagram/core/services/network_service/http_urls.dart';

class Repository {
  Repository._();
  static final Repository instance = Repository._();

  Future<BaseHttpModel<TagsResponseModel>> getTags() async {
    try {
      final response = await HttpClient.instance.request(
        method: HttpMethods.GET,
        path: HttpUrls.tags,
      );

      Log.success('getTags: \n', response!.body);

      final model =
          TagsResponseModel.fromJson((await jsonDecode(response.body) as List).map((e) => e.toString()).toList());

      return BaseHttpModel(data: model, statusCode: response.statusCode);
    } catch (e, s) {
      Log.error('Error: $e, Stack Trace: $s');

      rethrow;
    }
  }

  Future<BaseHttpModel<List<CatFromTagResponseModel>>> getCatsFromTag(String tag) async {
    try {
      final response = await HttpClient.instance.request(
        method: HttpMethods.GET,
        path: HttpUrls.catsFromTag,
        queryParameters: {'tags': tag},
      );

      Log.success('getCatsFromTag: \n', response!.body);

      final model = catsFromTagResponseModelFromJson(response.body, ReqContentType.photo, tag);

      return BaseHttpModel(data: model, statusCode: response.statusCode);
    } catch (e, s) {
      Log.error('Error: $e, Stack Trace: $s');

      rethrow;
    }
  }
}
