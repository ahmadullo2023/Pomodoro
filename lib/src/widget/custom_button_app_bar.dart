import 'package:flutter/material.dart';
import '../common/constants/app_color.dart';
import 'custom_notch.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    required this.isSettings,
    required this.onPressed,
    super.key,
  });

  final ValueNotifier<bool> isSettings;
  final void Function()? Function(bool) onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BottomAppBar(
      color: AppColor.mainColor,
      height: 90,
      shape: const CustomNotch(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      notchMargin: 20,
      padding: const EdgeInsets.only(top: 1),
      child: BottomAppBar(
        color: Colors.white,
        height: 90,
        shape: const CustomNotch(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        notchMargin: 20,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ValueListenableBuilder(
                valueListenable: isSettings,
                builder: (context, value, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconBuilder(
                      icon: value ? const Icon(Icons.home) : const Icon(Icons.home_outlined) ,
                      opacityValue: value ? 0.0 : 1.0,
                      onPressed: onPressed(false),
                    ),
                    SizedBox(width: size.width > 360 ? 40 : 20),
                    IconBuilder(
                      icon: value ? const Icon(Icons.settings) : const Icon(Icons.settings),
                      opacityValue: value ? 1.0 : 0.0,
                      onPressed: onPressed(true),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(flex: 2, child: SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}

class IconBuilder extends StatelessWidget {
  const IconBuilder({
    required this.icon,
    required this.opacityValue,
    required this.onPressed,
    super.key,
  });

  final Icon icon;
  final double opacityValue;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
        onPressed: onPressed,
        icon: icon,
      ),
      AnimatedOpacity(
        opacity: opacityValue,
        duration: const Duration(
          milliseconds: 400,
        ),
        child: const DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.mainColor,
          ),
          child: SizedBox(height: 10, width: 10),
        ),
      ),
    ],
  );
}
