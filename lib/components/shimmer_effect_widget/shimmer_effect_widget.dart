import 'dart:async';

import 'package:flutter/material.dart';

enum ShimmerEffectBrigthness { lighter, darker }

@immutable
final class ShimmerEffectWidget extends StatefulWidget {
  const ShimmerEffectWidget({
    super.key,
    this.light = ShimmerEffectBrigthness.darker,
  });
  final ShimmerEffectBrigthness? light;

  @override
  State<ShimmerEffectWidget> createState() => _ShimmerEffectWidgetState();
}

class _ShimmerEffectWidgetState extends State<ShimmerEffectWidget> {
  late Timer _timer;

  int _colorInt = -60;
  bool _isStart = true;
  final duration = const Duration(seconds: 1);
  final int depth = 20;

  @override
  void initState() {
    onReady();
    super.initState();
  }

  Future<void> onReady() async {
    await Future.delayed(
      const Duration(microseconds: 1),
      () {},
    );
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
    final color = Color.fromARGB(
      Colors.grey.shade200.alpha,
      Colors.grey.shade200.red + _colorInt,
      Colors.grey.shade200.green + _colorInt + 10,
      Colors.grey.shade200.blue + _colorInt + 10,
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
    // ignore: unused_element
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
