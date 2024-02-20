import 'dart:math' as math show pi;
import 'package:flutter/material.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({
    required this.value,
    required this.child,
    this.width = 2.0,
    this.color = const Color(0xFFFFFFFF),
    this.colorBG = const Color(0x4DFFFFFF),
    super.key,
  });

  final Widget child;
  final double value;
  final double width;
  final Color color;
  final Color colorBG;

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: IndicatorPaint(
          value: value,
          width: width,
          color: color,
          colorBG: colorBG,
        ),
        child: child,
      );
}

class IndicatorPaint extends CustomPainter {
  const IndicatorPaint({
    required this.value,
    required this.width,
    required this.color,
    required this.colorBG,
  });

  final double value;
  final double width;
  final Color color;
  final Color colorBG;

  @override
  void paint(Canvas canvas, Size size) {
    final paintBG = Paint()
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..color = colorBG
      ..style = PaintingStyle.stroke;

    final paint = Paint()
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..color = color
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      const Offset(0.5, 0.5) & size,
      0,
      2 * math.pi,
      false,
      paintBG,
    );

    canvas.drawArc(
      const Offset(0.5, 0.5) & size,
      -math.pi / 2,
      2 * math.pi * value,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant IndicatorPaint oldDelegate) {
    return value != oldDelegate.value;
  }
}
