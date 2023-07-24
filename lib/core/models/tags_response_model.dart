class TagsResponseModel {
  List<String> tags;

  TagsResponseModel({required this.tags});

  factory TagsResponseModel.fromJson(List<String> json) => TagsResponseModel(tags: json);

  Set<List<String>> toJson() => {tags};
}
