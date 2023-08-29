import 'package:flutter/material.dart';

class CDropdownList extends StatefulWidget {
  final Offset offset;
  final Size size;
  final Map<String, Widget> items;
  final LayerLink layerLink;
  final void Function(String) onNewItemSelected;
  final int visibleElementLength;
  final VoidCallback onTapOutOfMenu;

  const CDropdownList({
    required this.offset,
    required this.size,
    required this.items,
    required this.layerLink,
    required this.onNewItemSelected,
    required this.visibleElementLength,
    required this.onTapOutOfMenu,
    super.key,
  });

  @override
  State<CDropdownList> createState() => _CDropdownListState();
}

class _CDropdownListState extends State<CDropdownList> with SingleTickerProviderStateMixin {
  final scrollController = ScrollController();
  late final TextEditingController textEditingController;
  late final ItemsNotifier items;
  late final ScrollPhysics scrollPhysics;
  late final AnimationController animController;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    items = ItemsNotifier(items: widget.items);
    textEditingController = TextEditingController()..addListener(_search);

    scrollPhysics = widget.items.length > widget.visibleElementLength
        ? const AlwaysScrollableScrollPhysics()
        : const NeverScrollableScrollPhysics();

    _prepareAnimations();
    animController.forward();
  }

  void _search() => items.search(textEditingController.text, widget.items);

  void _prepareAnimations() {
    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    animation = CurvedAnimation(
      parent: animController,
      curve: Curves.linearToEaseOut,
    );
  }

  @override
  void dispose() {
    textEditingController
      ..removeListener(_search)
      ..dispose();

    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build method');

    return RepaintBoundary(
      child: Stack(
        children: [
          GestureDetector(
            onTap: widget.onTapOutOfMenu,
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          FadeTransition(
            opacity: animation,
            child: CustomSingleChildLayout(
              delegate: _MyDelegate(context: context, anchorSize: widget.size, offset: widget.offset),
              child: Material(
                color: Theme.of(context).cardColor,
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: textEditingController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            prefixIcon: Icon(Icons.search),
                            fillColor: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ),
                    if (items.value.isNotEmpty)
                      Expanded(
                        child: AnimatedBuilder(
                          animation: items,
                          builder: (context, child) {
                            // debugPrint('Animated Builder');

                            return Scrollbar(
                              child: ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: items.value.length,
                                physics: scrollPhysics,
                                controller: scrollController,
                                itemBuilder: (BuildContext context, int index) {
                                  final keys = items.value.keys.toList();
                                  final values = items.value.values.toList();

                                  return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: GestureDetector(
                                      onTap: () => widget.onNewItemSelected(keys[index]),
                                      child: values[index],
                                    ),
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return const Divider(color: Colors.red);
                                },
                              ),
                            );
                          },
                        ),
                      )
                    else
                      const Text('No Item Founded'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemsNotifier extends ChangeNotifier {
  Map<String, Widget> items;

  ItemsNotifier({this.items = const {}});

  Map<String, Widget> get value => items;

  void search(String searchKey, Map<String, Widget> allItems) {
    final tempItems = items;

    items = searchKey.isEmpty
        ? allItems
        : Map.fromEntries(allItems.entries.toList().where((element) => element.key.contains(searchKey)));

    if (items.length != tempItems.length) notifyListeners();
  }
}

class _MyDelegate extends SingleChildLayoutDelegate {
  final Size anchorSize;
  final Offset offset;
  final BuildContext context;

  _MyDelegate({
    required this.context,
    required this.anchorSize,
    required this.offset,
  });

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // we allow our child to be smaller than parent's constraint:

    return BoxConstraints(maxWidth: anchorSize.width, maxHeight: 200);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final screenHeight = MediaQuery.of(context).size.height;
    final emptyBottomHeight = screenHeight - (offset.dy + childSize.height + kBottomNavigationBarHeight);

    final dy = emptyBottomHeight > 0
        ? offset.dy + 40
        : keyboardHeight > 0
            ? screenHeight - (childSize.height + keyboardHeight)
            : offset.dy - childSize.height;

    return Offset(offset.dx, dy);
  }

  @override
  bool shouldRelayout(SingleChildLayoutDelegate oldDelegate) {
    /// return true;
    return this != oldDelegate;
  }
}
