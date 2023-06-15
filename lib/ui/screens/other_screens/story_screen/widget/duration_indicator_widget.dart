part of '../view/story_view.dart';

class _DurationIndicatorWidget extends StatefulWidget {
  final int indicatorLenght;
  final int currentStoryIndex;
  final StoryTimerController storyTimer;
  const _DurationIndicatorWidget({
    required this.indicatorLenght,
    required this.currentStoryIndex,
    required this.storyTimer,
  });

  @override
  State<_DurationIndicatorWidget> createState() => _DurationIndicatorWidgetState();
}

class _DurationIndicatorWidgetState extends State<_DurationIndicatorWidget> with TickerProviderStateMixin {
  double indicatorValue = 0;
  late final Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      var initialTime = widget.storyTimer.initialDuration.inMicroseconds;
      var remainTime = widget.storyTimer.remainTime!.inMicroseconds;
      var val = (initialTime - remainTime) / initialTime;

      setState(() {
        indicatorValue = val;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Row(
        children: List.generate(
          widget.indicatorLenght,
          (index) {
            var value = index == widget.currentStoryIndex
                ? indicatorValue
                : index >= widget.currentStoryIndex
                    ? 0.0
                    : 1.0;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 2, left: 2),
                child: SizedBox(
                  height: 4,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: LinearProgressIndicator(value: value),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
