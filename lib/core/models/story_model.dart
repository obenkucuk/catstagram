import 'package:catstagram/core/models/cats_from_tag_response_model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class StoryModel {
  StoryModel({
    required this.index,
    required this.name,
    required this.image,
    required this.isSeen,
    required this.storyList,
  });

  final int index;
  final String name;
  final String image;
  RxBool isSeen;
  final List<CatFromTagResponseModel> storyList;

  StoryModel copyWith({
    int? index,
    String? name,
    String? image,
    RxBool? isSeen,
    List<CatFromTagResponseModel>? storyList,
  }) {
    return StoryModel(
      index: index ?? this.index,
      name: name ?? this.name,
      image: image ?? this.image,
      isSeen: isSeen ?? this.isSeen,
      storyList: storyList ?? this.storyList,
    );
  }
}
