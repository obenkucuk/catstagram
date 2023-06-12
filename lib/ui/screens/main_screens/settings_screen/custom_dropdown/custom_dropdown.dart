import 'package:flutter/material.dart';
import '../../../../../theme/text_styles.dart';
import 'animated_dropdown.dart';

class CustomDropdown extends StatefulWidget {
  final Map<String, Widget> items;
  final Function(int) onSelected;
  final int? title;
  final TextStyle? textStyle;
  final double? dropdownWidth;
  final int itemHeight;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.onSelected,
    this.title,
    this.textStyle,
    this.dropdownWidth,
    this.itemHeight = 40,
  });

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

    RenderBox renderBox = dimensionKey.currentContext!.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);

    overlayEntry = OverlayEntry(builder: (context) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => hideOverlay(),
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
    });
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
          border: Border.all(color: Theme.of(context).dividerColor, width: 0.5),
          borderRadius: BorderRadius.circular(7),
          color: Theme.of(context).highlightColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.items.keys.toList()[selectedItem], style: widget.textStyle ?? s16W600(context)),
            RotatedBox(
              quarterTurns: overlayIsVisible ? 2 : 0,
              child: const Icon(Icons.keyboard_arrow_down_sharp),
            ),
          ],
        ),
      ),
    );
  }
}
