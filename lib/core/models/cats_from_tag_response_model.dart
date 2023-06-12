import 'dart:convert';

List<CatFromTagResponseModel> catsFromTagResponseModelFromJson(String str) =>
    List<CatFromTagResponseModel>.from(json.decode(str).map((x) => CatFromTagResponseModel.fromJson(x)));

class CatFromTagResponseModel {
  final String? id;
  final List<String>? tags;

  CatFromTagResponseModel({
    this.id,
    this.tags,
  });

  CatFromTagResponseModel copyWith({
    String? id,
    List<String>? tags,
  }) =>
      CatFromTagResponseModel(
        id: id ?? this.id,
        tags: tags ?? this.tags,
      );

  factory CatFromTagResponseModel.fromJson(Map<String, dynamic> json) => CatFromTagResponseModel(
        id: json["_id"],
        tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
      };
}
