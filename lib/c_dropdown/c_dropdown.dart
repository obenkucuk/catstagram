// ignore_for_file: cast_nullable_to_non_nullable

import 'package:catstagram/c_dropdown/c_dropdown_list.dart';
import 'package:catstagram/c_dropdown/c_dropdown_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DropdownTypes { icon, text }

@immutable
final class CDropdown extends StatefulWidget {
  final Map<String, Widget> items;
  final int visibleElementLength;
  final DropdownTypes cDropdownType;

  CDropdown({
    required this.items,
    this.visibleElementLength = 4,
    this.cDropdownType = DropdownTypes.text,
    super.key,
  }) : assert(items.isNotEmpty, 'Dropdown needs at least one item');

  @override
  State<CDropdown> createState() => _CDropdownState();
}

class _CDropdownState extends State<CDropdown> with SingleTickerProviderStateMixin {
  final layerLink = LayerLink();
  final key = GlobalKey();
  final DropdownNotifier overlayController = DropdownNotifier();

  late AnimationController animationController;
  late ValueNotifier<Animation<double>> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..addListener(() {
        setState(() {});
      });
    animation = ValueNotifier(Tween<double>(begin: 0, end: 1).animate(animationController));
    overlayController.selectedItem = widget.items.keys.toList().first;
  }

  void show() {
    overlayController
      ..renderBox(key: key)
      ..show(
        context: context,
        child: CDropdownList(
          offset: overlayController.offset,
          size: overlayController.size,
          items: widget.items,
          layerLink: layerLink,
          visibleElementLength: widget.visibleElementLength,
          onNewItemSelected: overlayController.updateSelectedItem,
          onTapOutOfMenu: close,
        ),
      );
  }

  void close() => overlayController.close();

  @override
  void dispose() {
    overlayController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //   print("build-------------");

    return AnimatedBuilder(
      key: key,
      animation: overlayController,
      builder: (context, child) {
        //   print('---------------------- ');

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: overlayController.mounted ? close : show,
          child: widget.cDropdownType == DropdownTypes.text
              ? Container(
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
                          overlayController.selectedItem,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      AnimatedRotation(
                        duration: const Duration(milliseconds: 300),
                        turns: overlayController.mounted ? 1 : 0,
                        child: RotatedBox(
                          quarterTurns: overlayController.mounted ? 2 : 0,
                          child: const Icon(Icons.keyboard_arrow_down_sharp),
                        ),
                      ),
                    ],
                  ),
                )
              : const Icon(Icons.desktop_windows),
        );
      },
    );
  }
}
