// ignore_for_file: cast_nullable_to_non_nullable, cascade_invocations
import 'package:flutter/material.dart';

class DropdownNotifier extends ChangeNotifier {
  OverlayEntry? _overlayEntry;
  Offset offset = Offset.zero;
  Size size = Size.zero;
  String selectedItem = '';

  // factory OverlayController() => _instance;
  // OverlayController._();
  // static final OverlayController _instance = OverlayController._();

  void renderBox({required GlobalKey key}) {
    final renderBox = key.currentContext!.findRenderObject() as RenderBox;
    offset = renderBox.localToGlobal(Offset.zero);
    size = renderBox.size;
  }

  void show({required BuildContext context, required Widget child}) {
    final overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(builder: (context) => child);
    overlayState.insert(_overlayEntry!);
    notifyListeners();
  }

  void updateSelectedItem(String value) {
    selectedItem = value;
    close();
    notifyListeners();
  }

  bool get mounted => _overlayEntry != null;

  void close() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    notifyListeners();
  }
}
