import 'package:catstagram/core/extensions/to_cats_id_url.dart';
import 'package:flutter/material.dart';

import '../../../../../core/models/cats_from_tag_response_model.dart';

class SingleStoryBuilder extends StatelessWidget {
  final CatFromTagResponseModel model;
  const SingleStoryBuilder({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    if (model.contentType == ReqContentType.video) {
      return const SizedBox();
    } else {
      return Image.network(
        model.id!.toCatsIdUrl,
        width: double.maxFinite,
        height: double.maxFinite,
        fit: BoxFit.cover,
      );
    }
  }
}
