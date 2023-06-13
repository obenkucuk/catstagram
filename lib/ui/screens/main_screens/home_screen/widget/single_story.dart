import 'package:catstagram/core/extensions/to_cats_id_url.dart';
import 'package:flutter/material.dart';
import '../../../../../core/models/cats_from_tag_response_model.dart';

class SingleStory extends StatelessWidget {
  final List<CatFromTagResponseModel>? catList;
  const SingleStory({super.key, this.catList});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: catList != null
          ? Column(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [Colors.yellow.shade600, Colors.orange, Colors.red]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              (catList!.first.id ?? 'H2NHTuNktH1nAf4a').toCatsIdUrl,
                            ),
                          ),
                        )),
                  ),
                ),
                FittedBox(child: Text(catList!.first.tags!.first)),
              ],
            )
          : const SizedBox(width: 80, child: CircularProgressIndicator.adaptive()),
    );
  }
}
