import 'package:flutter/material.dart';

class LazyLoadLoadingWidget extends StatelessWidget {
  const LazyLoadLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const FractionallySizedBox(
      widthFactor: 0.1,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 25),
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
