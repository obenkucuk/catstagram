import 'package:catstagram/components/custom_dropdown/animated_dropdown.dart';
import 'package:catstagram/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
final class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    required this.items,
    required this.onSelected,
    super.key,
    this.title,
    this.textStyle,
    this.dropdownWidth,
    this.itemHeight = 40,
  });
  final Map<String, Widget> items;
  final void Function(int) onSelected;
  final int? title;
  final TextStyle? textStyle;
  final double? dropdownWidth;
  final int itemHeight;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final GlobalKey dimensionKey = GlobalKey();
  late int selectedItem;
  bool overlayIsVisible = false;
  late OverlayEntry? overlayEntry;
  OverlayState? overlayState;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.title ?? 0;
  }

  void showOverlay() {
    setState(() => overlayIsVisible = true);

    final renderBox = dimensionKey.currentContext!.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);

    overlayEntry = OverlayEntry(
      builder: (context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              GestureDetector(
                onTap: hideOverlay,
                child: Container(color: Colors.transparent),
              ),
              Positioned(
                left: offset.dx,
                top: offset.dy + renderBox.size.height + 10,
                height: widget.itemHeight * widget.items.keys.length * 1.0,
                width: widget.dropdownWidth,
                child: AnimatedDropdown(
                  itemHeight: widget.itemHeight,
                  textStyle: widget.textStyle,
                  items: widget.items,
                  selectedItem: selectedItem,
                  onTap: (val) {
                    setState(() => selectedItem = val);
                    widget.onSelected(selectedItem);
                    hideOverlay();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
    overlayState = Overlay.of(context);
    overlayState!.insert(overlayEntry!);
  }

  void hideOverlay() {
    if (overlayEntry == null) return;
    overlayEntry!.remove();
    overlayEntry = null;
    setState(() => overlayIsVisible = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: dimensionKey,
      onTap: () {
        overlayIsVisible ? hideOverlay() : showOverlay();
        FocusScope.of(context).unfocus();
      },
      child: Container(
        width: widget.dropdownWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: CupertinoColors.tertiarySystemFill,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.items.keys.toList()[selectedItem],
                style: widget.textStyle ?? s16W600(context),
              ),
            ),
            AnimatedRotation(
              duration: const Duration(milliseconds: 200),
              turns: overlayIsVisible ? 0.5 : 0,
              child: RotatedBox(
                quarterTurns: overlayIsVisible ? 2 : 0,
                child: const Icon(Icons.keyboard_arrow_down_sharp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
