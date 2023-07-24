import 'package:catstagram/components/shimmer_effect_widget/shimmer_effect_widget.dart';
import 'package:catstagram/constants/assets_constants.dart';
import 'package:catstagram/core/models/search_history_and_found_model.dart';
import 'package:catstagram/core/services/localization_service/localization_service.dart';
import 'package:catstagram/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

part '../widget/not_found_widget.dart';
part '../widget/search_history_and_found_widget.dart';

enum SearchStatus { found, searching, history }

@immutable
final class SearchHistoryView extends StatefulWidget {
  const SearchHistoryView({
    required this.offset,
    required this.historyList,
    required this.onDelete,
    required this.onTap,
    required this.size,
    required this.searchStatus,
    required this.foundedList,
    super.key,
  });

  final Offset offset;
  final Size size;
  final List<SearchHistoryAndFoundModel> historyList;
  final List<SearchHistoryAndFoundModel> foundedList;
  final void Function(String value) onDelete;
  final void Function(String value) onTap;
  final SearchStatus searchStatus;

  @override
  State<SearchHistoryView> createState() => _SearchHistoryViewState();
}

class _SearchHistoryViewState extends State<SearchHistoryView> with SingleTickerProviderStateMixin {
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
  void didUpdateWidget(SearchHistoryView oldWidget) {
    super.didUpdateWidget(oldWidget);
    runExpand();

    if (widget.historyList != oldWidget.historyList) {
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

              /// If the search status is found, show the founded list
              if (widget.searchStatus == SearchStatus.found)
                if (widget.foundedList.isNotEmpty)
                  ...widget.foundedList.map((e) {
                    return _SearchHistoryAndFoundWidget(
                      title: e.keyword,
                      imageUrl: e.imageUrl,
                      onTap: (value) => widget.onTap(value),
                    );
                  })
                else
                  _NotFoundWidget(
                    height: MediaQuery.of(context).size.height - (widget.offset.dy + widget.size.height + 10),
                  ),

              /// If search status is searching, show the shimmer effect
              if (widget.searchStatus == SearchStatus.searching)
                ...List.generate(20, (i) => i).map((e) => const ShimmerEffectWidget()),

              /// when user didn't search anything, show the history list
              if (widget.searchStatus == SearchStatus.history)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      appLocalization(context).recentSearches,
                      style: s14W600(context),
                    ),
                    ...widget.historyList.map((e) {
                      return _SearchHistoryAndFoundWidget(
                        title: e.keyword,
                        imageUrl: e.imageUrl,
                        onTap: (value) => widget.onTap(value),
                        onDelete: (value) => widget.onDelete(value),
                      );
                    }),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
