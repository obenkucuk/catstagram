part of '../view/story_view.dart';

final class _StoryUserAreaWidget extends StatelessWidget {
  const _StoryUserAreaWidget({
    required this.onCloseTap,
    this.username,
    this.image,
  });

  final String? username;
  final String? image;
  final VoidCallback onCloseTap;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primaryContainer;

    return Row(
      children: [
        const SizedBox(width: 10),
        CircleAvatar(
          backgroundColor: color,
          backgroundImage: image != null ? NetworkImage(image!) : null,
        ),
        const SizedBox(width: 10),
        Text(username ?? '---', style: s14W400(context).copyWith(color: color)),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.ellipsis),
          color: color,
        ),
        IconButton(onPressed: onCloseTap, icon: Icon(Icons.close, color: color)),
      ],
    );
  }
}
