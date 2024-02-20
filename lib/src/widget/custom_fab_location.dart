import 'package:flutter/material.dart';

class CustomFABLocation extends FloatingActionButtonLocation {
  const CustomFABLocation();

  @override
  Offset getOffset(
      ScaffoldPrelayoutGeometry scaffoldGeometry,
      ) =>
      Offset(
        scaffoldGeometry.scaffoldSize.width -
            scaffoldGeometry.floatingActionButtonSize.width * 1.7,
        scaffoldGeometry.contentBottom -
            (scaffoldGeometry.floatingActionButtonSize / 2).height,
      );
}
