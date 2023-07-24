class TagsResponseModel {
  TagsResponseModel({required this.tags});

  factory TagsResponseModel.fromJson(List<String> json) => TagsResponseModel(tags: json);

  List<String> tags;
  Set<List<String>> toJson() => {tags};
}
