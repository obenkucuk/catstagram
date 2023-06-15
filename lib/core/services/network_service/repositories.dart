import 'dart:convert';
import '../../logger.dart';
import '../../models/cats_from_tag_response_model.dart';
import '../../models/tags_response_model.dart';
import 'base_http_model.dart';
import 'http_enums.dart';
import 'http_client.dart';
import 'http_urls.dart';

class Repository {
  Repository._();
  static final Repository instance = Repository._();

  Future<BaseHttpModel<TagsResponseModel>> getTags() async {
    try {
      var response = await HttpClient.instance.request(
        method: HttpMethods.GET,
        path: HttpUrls.tags,
      );

      Log.success('getTags: \n', response!.body);

      TagsResponseModel model =
          TagsResponseModel.fromJson((await jsonDecode(response.body) as List).map((e) => e.toString()).toList());

      return BaseHttpModel(data: model, statusCode: response.statusCode);
    } catch (e, s) {
      Log.error('Error: $e, Stack Trace: $s');

      rethrow;
    }
  }

  Future<BaseHttpModel<List<CatFromTagResponseModel>>> getCatsFromTag(String tag) async {
    try {
      var response = await HttpClient.instance.request(
        method: HttpMethods.GET,
        path: HttpUrls.catsFromTag,
        queryParameters: {'tags': tag},
      );

      Log.success('getCatsFromTag: \n', response!.body);

      var model = catsFromTagResponseModelFromJson(response.body, ReqContentType.photo, tag);

      return BaseHttpModel(data: model, statusCode: response.statusCode);
    } catch (e, s) {
      Log.error('Error: $e, Stack Trace: $s');

      rethrow;
    }
  }
}
