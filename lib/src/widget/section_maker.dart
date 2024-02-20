import 'package:flutter/material.dart';
import '../common/constants/app_color.dart';
import '../common/model/timer_model.dart';

class SectionMaker extends StatelessWidget {
  const SectionMaker({
    required this.data,
    required this.pageCount,
    required this.timerPageController,
    required this.indicatorValue,
    required this.onPressed,
    super.key,
  });

  final ValueNotifier<double> indicatorValue;
  final PageController timerPageController;
  final ValueNotifier<int> pageCount;
  final List<TimerData> data;
  final void Function()? Function(int, int) onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: size.height * 0.1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: data
              .map(
                (e) => ValueListenableBuilder(
              valueListenable: pageCount,
              builder: (context, value, child) => _Buttons(
                item: e,
                page: value,
                onPressed: onPressed,
              ),
            ),
          )
              .toList(),
        ),
        Center(
          child: SizedBox(
            width: size.width > 360 ? 250 : 215,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              child: SizedBox(
                height: 6,
                width: double.infinity,
                child: ColoredBox(
                  color: AppColor.restartIconBGColor,
                  child: ValueListenableBuilder(
                    valueListenable: pageCount,
                    builder: (context, value, child) {
                      return AnimatedAlign(
                        alignment: switch (pageCount.value) {
                          1 => Alignment.center,
                          2 => Alignment.centerRight,
                          _ => Alignment.centerLeft,
                        },
                        duration: const Duration(milliseconds: 200),
                        child: const ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          child: SizedBox(
                            height: 6,
                            width: 55,
                            child: ColoredBox(
                              color: AppColor.mainColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({
    required this.page,
    required this.item,
    required this.onPressed,
  });

  final int page;
  final TimerData item;
  final void Function()? Function(int, int) onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(
          AppColor.transparent,
        ),
      ),
      onPressed: onPressed(page, item.id),
      child: (page == item.id)
          ? Text(
        item.sectionName,
        style: TextStyle(
          color: AppColor.mainColor,
          fontSize: size.width > 360 ? 20 : 14,
        ),
      )
          : Text(
        item.sectionName,
        style: TextStyle(
          fontSize: size.width > 360 ? 14 : 10,
        ),
      ),
    );
  }
}
