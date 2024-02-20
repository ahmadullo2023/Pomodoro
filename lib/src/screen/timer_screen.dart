import 'dart:async';
import 'package:flutter/material.dart';
import '../common/constants/app_color.dart';
import '../common/model/timer_model.dart';
import '../widget/custom_app_bar.dart';
import '../widget/custom_button_app_bar.dart';
import '../widget/custom_fab_location.dart';
import '../widget/setting_page.dart';
import 'timer_page.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final indicatorValue = ValueNotifier<double>(1.0);
  final pageCount = ValueNotifier<int>(0);
  final isSettings = ValueNotifier<bool>(false);
  final isTimerStarted = ValueNotifier<bool>(false);
  late final PageController timerPageController;

  Timer? _timer;

  List<TimerData> data = [
    TimerData(
      id: 0,
      constTime: 60000,
      sectionName: "short break",
    ),
    TimerData(
      id: 1,
      constTime: 1500000,
      sectionName: "pomodoro",
    ),
    TimerData(
      id: 2,
      constTime: 2400000,
      sectionName: "long break",
    ),
  ];

  @override
  void initState() {
    super.initState();
    timerPageController = PageController();
  }

  @override
  void dispose() {
    timerPageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void Function()? fABPressed() {
    if (isTimerStarted.value) return null;

    if (isSettings.value) {
      return () async {
        for (int i = 0; i < data.length; i++) {
          data[i].constTime = data[i].selectedTime.value;
        }

        isSettings.value = false;

        await Future.delayed(const Duration(milliseconds: 50), () {
          timerPageController.jumpToPage(
            pageCount.value,
          );
        });
      };
    } else {
      for (int i = 0; i < data.length; i++) {
        data[i].selectedTime.value = data[i].constTime;
      }

      return () {
        isTimerStarted.value = true;

        _timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
          if (indicatorValue.value == 0.0) {
            onRefreshTapped(false)?.call();

            return;
          }

          data[pageCount.value].selectedTime.value -= 20;
          int timerTime = data[pageCount.value].selectedTime.value;
          indicatorValue.value = timerTime / data[pageCount.value].constTime;
        });
      };
    }
  }

  void Function()? bottomPressed(bool isSettingsTapped) {
    if (isTimerStarted.value) return null;
    if (isSettings.value == isSettingsTapped) return null;

    return () async {
      isSettings.value = isSettingsTapped;

      if (!isSettings.value) {
        await Future.delayed(
          const Duration(milliseconds: 50),
          () {
            timerPageController.jumpToPage(
              pageCount.value,
            );
          },
        );
      }
    };
  }

  void Function()? onRefreshTapped(bool isSettingsValue) {
    if (isSettingsValue) return null;

    return () {
      _timer?.cancel();

      data[pageCount.value].selectedTime.value =
          data[pageCount.value].constTime;
      indicatorValue.value = 1.0;
      isTimerStarted.value = false;
    };
  }

  void onSettingsClosed() async {
    isSettings.value = false;
    await Future.delayed(const Duration(milliseconds: 50), () {
      timerPageController.jumpToPage(
        pageCount.value,
      );
    });
  }

  void Function()? onSectionChanged(int value, int itemLocation) {
    if (isTimerStarted.value) return null;

    if (value == itemLocation) {
      return () {};
    } else {
      return () {
        pageCount.value = itemLocation;
        timerPageController.animateToPage(
          itemLocation,
          duration: const Duration(milliseconds: 200),
          curve: Curves.linear,
        );
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: isSettings,
                builder: (context, value, child) {
                  return CustomAppBar(
                    onPressed: onRefreshTapped(value),
                  );
                },
              ),
            ),
            Expanded(
              flex: 4,
              child: ValueListenableBuilder(
                valueListenable: isSettings,
                builder: (context, value, child) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: value
                        ? SettingPage(
                            data: data,
                            onClosed: onSettingsClosed,
                          )
                        : ValueListenableBuilder(
                            valueListenable: isTimerStarted,
                            builder: (context, value, child) {
                              return TimerPage(
                                data: data,
                                pageCount: pageCount,
                                isTimerStarted: value,
                                indicatorValue: indicatorValue,
                                timerPageController: timerPageController,
                                onSectionChanged: onSectionChanged,
                              );
                            },
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox.square(
        dimension: 75,
        child: ValueListenableBuilder(
          valueListenable: isTimerStarted,
          builder: (context, _, child) {
            return ValueListenableBuilder(
              valueListenable: isSettings,
              builder: (context, value, child) {
                return FloatingActionButton(
                  onPressed: fABPressed(),
                  backgroundColor: AppColor.mainColor,
                  shape: const CircleBorder(),
                  child: Icon(
                    value ? Icons.play_arrow : Icons.play_arrow,
                    size: 40,
                    color: Colors.white,
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButtonLocation: const CustomFABLocation(),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: isTimerStarted,
        builder: (context, value, child) {
          return CustomBottomAppBar(
            isSettings: isSettings,
            onPressed: bottomPressed,
          );
        },
      ),
    );
  }
}
