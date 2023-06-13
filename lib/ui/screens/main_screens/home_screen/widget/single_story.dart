import 'package:catstagram/core/extensions/to_cats_id_url.dart';
import 'package:catstagram/theme/text_styles.dart';
import 'package:flutter/material.dart';
import '../../../../../core/models/cats_from_tag_response_model.dart';

class SingleStory extends StatelessWidget {
  final CatFromTagResponseModel? cat;
  const SingleStory({super.key, this.cat});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: cat != null
            ? Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
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
                                (cat!.id ?? 'H2NHTuNktH1nAf4a').toCatsIdUrl,
                              ),
                            ),
                          )),
                    ),
                  ),
                  FittedBox(child: Text(cat!.tags!.first, style: s12W400(context))),
                ],
              )
            : CircleAvatar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                radius: 40,
                child: const CircularProgressIndicator.adaptive(),
              ));
  }
}
