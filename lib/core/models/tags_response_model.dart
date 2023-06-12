class TagsResponseModel {
  List<String> tags;

  TagsResponseModel({required this.tags});

  factory TagsResponseModel.fromJson(json) => TagsResponseModel(tags: json);

  Set<List<String>> toJson() => {tags};
}
