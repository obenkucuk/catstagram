import 'package:flutter/material.dart';

class CustomDropdownExampleItem extends StatelessWidget {
  final Widget child;
  const CustomDropdownExampleItem({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(5),
      ),
      child: child,
    );
  }
}
