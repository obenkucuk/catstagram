import 'dart:async';

import 'package:flutter/material.dart';

enum ShimmerEffectBrigthness { lighter, darker }

@immutable
class ShimmerEffectWidget extends StatefulWidget {
  final ShimmerEffectBrigthness? light;

  const ShimmerEffectWidget({Key? key, this.light = ShimmerEffectBrigthness.darker}) : super(key: key);

  @override
  State<ShimmerEffectWidget> createState() => _ShimmerEffectWidgetState();
}

class _ShimmerEffectWidgetState extends State<ShimmerEffectWidget> {
  late Timer _timer;

  int _colorInt = 5;
  late final Brightness _brightness;
  bool _isStart = true;
  final duration = const Duration(seconds: 1);
  final int depth = 20;

  @override
  void initState() {
    _brightness = widget.light == ShimmerEffectBrigthness.lighter ? Brightness.dark : Brightness.light;

    _colorInt = _brightness == Brightness.dark
        ? 5
        : (_brightness == Brightness.light ? -50 : (_brightness == Brightness.dark ? 5 : -50));

    onReady();
    super.initState();
  }

  onReady() async {
    await Future.delayed(const Duration(microseconds: 1));
    setState(() {
      if (_isStart) {
        _colorInt = _colorInt + depth;
      } else {
        _colorInt = _colorInt - depth;
      }
    });
    _timer = Timer.periodic(duration, (timer) {
      setState(() {
        if (_isStart) {
          _colorInt = _colorInt - depth;
        } else {
          _colorInt = _colorInt + depth;
        }
        _isStart = !_isStart;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer.isActive) _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Color.fromARGB(
      Theme.of(context).scaffoldBackgroundColor.alpha,
      Theme.of(context).scaffoldBackgroundColor.red + _colorInt + 10,
      Theme.of(context).scaffoldBackgroundColor.green + _colorInt + 10,
      Theme.of(context).scaffoldBackgroundColor.blue + _colorInt + 10,
    );

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ShimmerBox(
            color: color,
            height: MediaQuery.of(context).size.width * .12,
            width: MediaQuery.of(context).size.width * .12,
            borderRadius: MediaQuery.of(context).size.width * .06,
            margin: 10,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ShimmerBox(
                color: color,
                height: 10,
                width: MediaQuery.of(context).size.width * .7,
                borderRadius: 10,
              ),
              const SizedBox(height: 5),
              _ShimmerBox(
                color: color,
                height: 10,
                width: MediaQuery.of(context).size.width * .5,
                borderRadius: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({
    required this.color,
    required this.height,
    required this.width,
    required this.borderRadius,
    this.duration = const Duration(seconds: 1),
    this.margin = 0,
  });

  final Color color;
  final double height;
  final double width;
  final double borderRadius;
  final Duration duration;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.symmetric(vertical: margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: color,
      ),
      duration: duration,
      height: height,
      width: width,
    );
  }
}
