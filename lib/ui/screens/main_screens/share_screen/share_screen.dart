import 'package:catstagram/ui/screens/main_screens/share_screen/controller/share_controller.dart';
import 'package:catstagram/ui/screens/main_screens/share_screen/view/share_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShareController>(
      init: ShareController(),
      builder: (controller) => const ShareView(),
    );
  }
}
