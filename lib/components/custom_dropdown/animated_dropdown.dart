import 'package:flutter/material.dart';

@immutable
final class AnimatedDropdown extends StatefulWidget {
  const AnimatedDropdown({
    required this.items,
    required this.selectedItem,
    required this.onTap,
    required this.itemHeight,
    super.key,
    this.textStyle,
    this.onValueChange,
  });

  final Map<String, Widget> items;
  final int selectedItem;
  final TextStyle? textStyle;
  final void Function(int) onTap;
  final void Function(String)? onValueChange;
  final int itemHeight;

  @override
  State<AnimatedDropdown> createState() => _AnimatedDropdownState();
}

class _AnimatedDropdownState extends State<AnimatedDropdown> with SingleTickerProviderStateMixin {
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
      duration: const Duration(milliseconds: 600),
    )..addStatusListener((status) {});

    animation = CurvedAnimation(
      parent: animController,
      curve: Curves.linearToEaseOut,
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
  void didUpdateWidget(AnimatedDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    runExpand();
  }

  @override
  void dispose() {
    animController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 5,
        borderRadius: BorderRadius.circular(7),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.items.keys.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => widget.onTap(index),
              child: ColoredBox(
                color: Colors.transparent,
                child: SizedBox(
                  height: widget.itemHeight.toDouble(),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ColoredBox(
                      color: Colors.transparent,
                      child: widget.items.values.toList()[index],
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 0.5,
              color: Theme.of(context).disabledColor,
            );
          },
        ),
      ),
    );
  }
}
