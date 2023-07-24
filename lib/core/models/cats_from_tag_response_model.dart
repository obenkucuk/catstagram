import 'dart:convert';

enum ReqContentType { photo, video }

List<CatFromTagResponseModel> catsFromTagResponseModelFromJson(
  String str,
  ReqContentType contentType,
  String tag,
) =>
    List<CatFromTagResponseModel>.from(
      json.decode(str).map(
            (x) => CatFromTagResponseModel.fromJsonForCatApi(
              x as Map<String, dynamic>,
              contentType,
              tag,
            ),
          ),
    );

class CatFromTagResponseModel {
  CatFromTagResponseModel({
    required this.contentType,
    this.id,
    this.tags,
    this.videoUrl,
  });

  factory CatFromTagResponseModel.fromJsonForCatApi(
    Map<String, dynamic> json,
    ReqContentType contentType,
    String tag,
  ) =>
      CatFromTagResponseModel(
        id: json['_id'] as String,
        tags: json['tags'] == null ? [tag] : List<String>.from(json['tags']!.map((x) => x)),
        contentType: contentType,
      );

  final String? id;
  final ReqContentType contentType;
  final List<String>? tags;
  final String? videoUrl;
}
