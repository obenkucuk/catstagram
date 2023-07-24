import 'package:catstagram/main/my_bottom_bar_models.dart';
import 'package:catstagram/theme/app_colors.dart';
import 'package:catstagram/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static MyBottomBar? myBottomBar;

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late final MyBottomBar? myBottomBar = MainScreen.myBottomBar;

  bool isTabBarVisible = true;
  String _scaffoldMessage = '';
  bool isMessengerActive = false;
  Color _scaffoldColor = AppColorsX.error;

  void hideTabBar({required bool val}) => setState(() => isTabBarVisible = val);

  Future<void> showSnacbar(String? message, [ScaffoldMessengerType type = ScaffoldMessengerType.error]) async {
    if (type == ScaffoldMessengerType.success) {
      _scaffoldColor = AppColorsX.green;
    } else {
      _scaffoldColor = AppColorsX.error;
    }
    if (!isMessengerActive) {
      setState(() {
        isMessengerActive = true;

        _scaffoldMessage = message ?? 'Unknown Exception';
      });
    }

    await Future.delayed(
      const Duration(seconds: 3),
      () {},
    );
    if (isMessengerActive) {
      setState(() {
        isMessengerActive = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenInheritedWidget(
      state: this,
      child: Scaffold(
        body: myBottomBar != null ? myBottomBar!.elements.map((e) => e.child).toList()[_selectedIndex] : null,
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isTabBarVisible ? kBottomNavigationBarHeight + MediaQuery.of(context).padding.bottom : 0,
              child: CupertinoTabBar(
                height: isTabBarVisible ? kBottomNavigationBarHeight + MediaQuery.of(context).padding.bottom : 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                currentIndex: _selectedIndex,
                onTap: (int index) => setState(() => _selectedIndex = index),
                items: myBottomBar!.elements.map(
                  (e) {
                    return BottomNavigationBarItem(
                      icon: Icon(e.iconData),
                      // label: e.label,
                    );
                  },
                ).toList(),
              ),
            ),
            ColoredBox(
              color: _scaffoldColor,
              child: AnimatedContainer(
                curve: Curves.linearToEaseOut,
                duration: const Duration(milliseconds: 300),
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.005),
                height: isMessengerActive ? MediaQuery.of(context).size.height * 0.06 : 0,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  _scaffoldMessage,
                  style: s14W400(context).copyWith(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

@immutable
final class MainScreenInheritedWidget extends InheritedWidget {
  const MainScreenInheritedWidget({
    required this.state,
    required super.child,
    super.key,
  });
  final MainScreenState state;

  static MainScreenState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MainScreenInheritedWidget>()!.state;
  }

  @override
  bool updateShouldNotify(covariant MainScreenInheritedWidget oldWidget) {
    return state.isMessengerActive != oldWidget.state.isMessengerActive ||
        state.isTabBarVisible != oldWidget.state.isTabBarVisible;
  }
}

enum ScaffoldMessengerType { error, success, info }
