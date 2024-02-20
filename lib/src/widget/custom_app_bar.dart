import 'package:flutter/material.dart';
import '../common/constants/app_color.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    required this.onPressed,
    super.key,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "POMODORO",
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColor.mainColor,
          ),
        ),
        SizedBox(
          width: switch (size.width) {
            > 600 => size.width * 0.1,
            < 360 => size.width * 0.1,
            _ => size.width * 0.2,
          },
        ),
        Center(
          child: SizedBox.square(
            dimension: 46,
            child: GestureDetector(
              onTap: onPressed,
              child: const Material(
                color: AppColor.restartIconBGColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Center(
                  child: Icon(Icons.refresh,
                    size: 22,
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
