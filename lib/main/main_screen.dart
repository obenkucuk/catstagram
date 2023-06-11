import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/text_styles.dart';
import 'my_bottom_bar_models.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static MyBottomBar? myBottomBar;

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late final MyBottomBar? myBottomBar = MainScreen.myBottomBar;

  String _scaffoldMessage = '';
  bool isMessengerActive = false;
  Color _scaffoldColor = AppColorsX.error;

//tabbar screens

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

    await Future.delayed(const Duration(seconds: 3));
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
            if (Platform.isAndroid && myBottomBar != null)
              NavigationBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  onDestinationSelected: (int index) => setState(() => _selectedIndex = index),
                  selectedIndex: _selectedIndex,
                  destinations: myBottomBar!.elements
                      .map((e) => NavigationDestination(
                            icon: Icon(e.iconData),
                            label: e.label,
                          ))
                      .toList())
            else if (Platform.isIOS && myBottomBar != null)
              CupertinoTabBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                currentIndex: _selectedIndex,
                onTap: (int index) => setState(() => _selectedIndex = index),
                items: myBottomBar!.elements
                    .map((e) => BottomNavigationBarItem(
                          icon: Icon(e.iconData),
                          label: e.label,
                        ))
                    .toList(),
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
                  style: s14W400.copyWith(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MainScreenInheritedWidget extends InheritedWidget {
  const MainScreenInheritedWidget({
    super.key,
    required this.state,
    required super.child,
  });
  final MainScreenState state;

  static MainScreenState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MainScreenInheritedWidget>()!.state;
  }

  @override
  bool updateShouldNotify(covariant MainScreenInheritedWidget oldWidget) {
    return state.isMessengerActive != oldWidget.state.isMessengerActive;
  }
}

enum ScaffoldMessengerType { error, success, info }
