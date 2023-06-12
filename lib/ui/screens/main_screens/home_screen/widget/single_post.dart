import 'package:catstagram/core/extensions/to_cats_id_url.dart';
import 'package:catstagram/theme/text_styles.dart';
import 'package:flutter/material.dart';
import '../../../../../core/models/cats_from_tag_response_model.dart';

class SinglePost extends StatelessWidget {
  final List<CatFromTagResponseModel>? catList;
  const SinglePost({super.key, this.catList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //post header
        ListTile(
          contentPadding: const EdgeInsets.only(left: 10),
          leading: Container(
            width: MediaQuery.of(context).size.width * .08,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: catList != null
                  ? DecorationImage(
                      image: NetworkImage((catList!.first.id ?? 'H2NHTuNktH1nAf4a').toCatsIdUrl), fit: BoxFit.cover)
                  : null,
            ),
            child: catList == null ? const CircularProgressIndicator.adaptive() : null,
          ),
          title: Text(catList != null ? catList!.first.tags!.first : ''),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
          ),
        ),

        //post image
        SizedBox.square(
          dimension: MediaQuery.of(context).size.width,
          child: catList == null
              ? const CircularProgressIndicator.adaptive()
              : Image.network(
                  (catList!.last.id ?? 'H2NHTuNktH1nAf4a').toCatsIdUrl,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.width,
                ),
        ),

        //post footer
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.comment_outlined)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
            const Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border)),
          ],
        ),

        //post likes
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: 'Liked by ', style: s14W400(context)),
                TextSpan(text: catList != null ? catList!.last.tags!.first : '', style: s14W700(context)),
                TextSpan(text: ' and', style: s14W400(context)),
                TextSpan(text: ' others', style: s14W700(context)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
