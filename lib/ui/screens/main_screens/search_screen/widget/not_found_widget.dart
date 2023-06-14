part of '../view/search_history_view.dart';

/// not found widget for the search view
class _NotFoundWidget extends StatelessWidget {
  const _NotFoundWidget({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FractionallySizedBox(widthFactor: 0.3, child: Lottie.asset(AssetConstants.notFound)),
          Center(child: Text('Not Found any cat!', style: s18W500(context))),
        ],
      ),
    );
  }
}
