import 'package:catstagram/core/extensions/to_cats_id_url.dart';
import 'package:catstagram/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/models/cats_from_tag_response_model.dart';

class SinglePost extends StatelessWidget {
  final CatFromTagResponseModel? catList;
  const SinglePost({super.key, this.catList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// Post Header
        ListTile(
          contentPadding: const EdgeInsets.only(left: 10),
          leading: Container(
            width: MediaQuery.of(context).size.width * .08,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: catList != null
                  ? DecorationImage(
                      image: NetworkImage((catList!.id ?? 'H2NHTuNktH1nAf4a').toCatsIdUrl),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: catList == null ? const CircularProgressIndicator.adaptive() : null,
          ),
          title: Text(catList != null ? catList!.tags!.first : ''),
          trailing: IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.ellipsis)),
        ),

        /// Post Image
        if (catList != null)
          Image.network(
            (catList!.id ?? 'H2NHTuNktH1nAf4a').toCatsIdUrl,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
          ),

        /// Post Footer
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.heart),
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.chat_bubble),
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.paperplane),
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.bookmark),
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ],
        ),

        /// Post Likes
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: 'Liked by ', style: s14W400(context)),
                TextSpan(text: catList != null ? catList!.tags!.first : '', style: s14W700(context)),
                TextSpan(text: ' and', style: s14W400(context)),
                TextSpan(text: ' others', style: s14W700(context)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
