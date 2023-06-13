import 'package:catstagram/core/services/localization_service/localization_service.dart';
import 'package:catstagram/ui/screens/main_screens/search_screen/controller/search_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../components/shimmer_effect_widget/shimmer_effect_widget.dart';
import '../../../../../theme/text_styles.dart';

enum SearchStatus { found, searching, error, history }

class SearchHistory extends StatefulWidget {
  final Offset offset;
  final Size size;
  final List<SearchHistoryModel> list;
  final Function(String value) onDelete;
  final Function(String value) onTap;
  final SearchStatus searchStatus;

  const SearchHistory({
    Key? key,
    required this.offset,
    required this.list,
    required this.onDelete,
    required this.onTap,
    required this.size,
    required this.searchStatus,
  }) : super(key: key);

  @override
  State<SearchHistory> createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<SearchHistory> with SingleTickerProviderStateMixin {
  bool displayOverly = true;

  late AnimationController animController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();

    runExpand();
  }

  void prepareAnimations() {
    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addStatusListener((status) {});

    animation = CurvedAnimation(
      parent: animController,
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.linearToEaseOut,
    );
  }

  void runExpand() {
    if (displayOverly) {
      animController.forward();
    } else {
      animController.reverse();
    }
  }

  @override
  void didUpdateWidget(SearchHistory oldWidget) {
    super.didUpdateWidget(oldWidget);
    runExpand();

    if (widget.list != oldWidget.list) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    animController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.offset.dy + widget.size.height + 10,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - (widget.offset.dy + widget.size.height + 10),
      child: FadeTransition(
        opacity: animation,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(top: BorderSide(width: 0.5, color: Theme.of(context).dividerColor)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(height: 10),
              Text(appLocalization(context).recentSearches, style: s14W600(context)),
              if (widget.searchStatus == SearchStatus.searching)
                ...List.generate(20, (i) => i).map((e) => const ShimmerEffectWidget()).toList(),
              if (widget.searchStatus == SearchStatus.history)
                ...widget.list.map((e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(backgroundColor: Colors.amber),
                        const Spacer(flex: 1),
                        GestureDetector(
                          onTap: () async => await widget.onTap(e.keyword),
                          child: Text(e.keyword, style: s16W400(context)),
                        ),
                        const Spacer(flex: 15),
                        GestureDetector(
                          onTap: () async => await widget.onDelete(e.keyword),
                          child: Icon(
                            CupertinoIcons.delete_simple,
                            size: 16,
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                        )
                      ],
                    ),
                  );
                }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
