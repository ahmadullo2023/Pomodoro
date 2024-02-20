import 'dart:async';
import 'package:flutter/material.dart';
import '../common/constants/app_color.dart';
import '../common/model/timer_model.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({
    required this.data,
    required this.onClosed,
    super.key,
  });

  final List<TimerData> data;
  final void Function() onClosed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Align(
      alignment: const Alignment(0, -.9),
      child: SizedBox(
        height: size.width > 360 ? 400 : 330,
        width: size.width > 360 ? 300 : 230,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
            color: AppColor.mainColor,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: size.width > 360 ? 24 : 18,
                        fontWeight: FontWeight.w600,
                        color: AppColor.white,
                      ),
                    ),
                    CloseButton(
                      style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 0.0),
                        ),
                        visualDensity: VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                      ),
                      color: AppColor.white,
                      onPressed: onClosed,
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                flex: 7,
                child: Column(
                  children: [
                    Text(
                      "TIME (MINUTES)",
                      style: TextStyle(
                        color: AppColor.white70,
                        fontSize: size.width > 360 ? 18 : 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: data.map<Widget>((e) => MinuteAdder(e)).toList(),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Text(
                      "FONT",
                      style: TextStyle(
                        color: AppColor.white70,
                        fontSize: size.width > 360 ? 18 : 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                            (index) => Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: CircleAvatar(
                            backgroundColor: AppColor.white,
                            radius: size.width > 360 ? 15 : 10,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MinuteAdder extends StatefulWidget {
  const MinuteAdder(this.item, {super.key});

  final TimerData item;

  @override
  State<MinuteAdder> createState() => _MinuteAdderState();
}

class _MinuteAdderState extends State<MinuteAdder> {
  Timer? timer;

  void onTapDownDecrement(TapDownDetails details) {
    if (widget.item.selectedTime.value > 60000) {
      widget.item.selectedTime.value -= 60000;
    }

    timer = Timer.periodic(
      const Duration(milliseconds: 200),
          (t) {
        if (widget.item.selectedTime.value > 60000) {
          widget.item.selectedTime.value -= 60000;
        }
      },
    );
  }

  void onTapDownIncrement(TapDownDetails details) {
    if (widget.item.selectedTime.value < 3600000) {
      widget.item.selectedTime.value += 60000;
    }

    timer = Timer.periodic(
      const Duration(milliseconds: 200),
          (t) {
        if (widget.item.selectedTime.value < 3600000) {
          widget.item.selectedTime.value += 60000;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                widget.item.sectionName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: AppColor.white70,
                  fontSize: size.width > 360 ? 18 : 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Card(
                elevation: 0,
                color: AppColor.white40,
                child: SizedBox(
                  height: 40,
                  width: 120,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTapDown: onTapDownDecrement,
                        onTapUp: (TapUpDetails details) => timer?.cancel(),
                        onTapCancel: () => timer?.cancel(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            size: size.width > 360 ? 18 : 14,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                      ValueListenableBuilder(
                          valueListenable: widget.item.selectedTime,
                          builder: (context, value, child) {
                            return Expanded(
                              child: Text(
                                ((value ~/ 1000) ~/ 60).toString().padLeft(2, "0"),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColor.white70,
                                  fontSize: size.width > 360 ? 18 : 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }),
                      GestureDetector(
                        onTapDown: onTapDownIncrement,
                        onTapUp: (TapUpDetails details) => timer?.cancel(),
                        onTapCancel: () => timer?.cancel(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: size.width > 360 ? 18 : 14,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
