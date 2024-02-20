import 'package:flutter/material.dart';

class TimerData {
  final int id;
  int constTime;
  final String sectionName;
  final ValueNotifier<int> selectedTime;

  TimerData({
    required this.id,
    required this.constTime,
    required this.sectionName,
  }) : selectedTime = ValueNotifier<int>(constTime);
}
