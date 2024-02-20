import 'package:flutter/material.dart';
import '../common/model/timer_model.dart';
import '../widget/custom_timer.dart';
import '../widget/section_maker.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({
    required this.data,
    required this.pageCount,
    required this.indicatorValue,
    required this.isTimerStarted,
    required this.timerPageController,
    required this.onSectionChanged,
    super.key,
  });

  final ValueNotifier<double> indicatorValue;
  final PageController timerPageController;
  final ValueNotifier<int> pageCount;
  final bool isTimerStarted;
  final List<TimerData> data;
  final void Function()? Function(int, int) onSectionChanged;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Expanded(
        child: CustomTimerView(
          indicatorValue: indicatorValue,
          timerPageController: timerPageController,
          data: data,
        ),
      ),
      Expanded(
        child: SectionMaker(
          data: data,
          pageCount: pageCount,
          timerPageController: timerPageController,
          indicatorValue: indicatorValue,
          onPressed: onSectionChanged,
        ),
      ),
    ],
  );
}
