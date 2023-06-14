part of '../view/search_history_view.dart';

/// search history and found widget for the search history view single item
class _SearchHistoryAndFoundWidget extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final Function(String value) onTap;
  final Function(String value)? onDelete;

  const _SearchHistoryAndFoundWidget({
    this.imageUrl,
    this.title,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: imageUrl == null ? const Icon(CupertinoIcons.at_circle) : null,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () => onTap.call(title ?? ''),
                child: Text(
                  title ?? '',
                  style: s16W400(context),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          if (onDelete != null)
            GestureDetector(
              onTap: () => onDelete!.call(title ?? ''),
              child: Icon(
                CupertinoIcons.delete_simple,
                size: 16,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            )
        ],
      ),
    );
  }
}
