import 'dart:math' as math;
import 'package:flutter/material.dart';

class PieProgressPainter extends CustomPainter {
  PieProgressPainter({
    required this.value,
    required this.backgroundColor,
    required this.color,
  }) : super();

  final double value;

  /// The color in the background of the circle
  final Color backgroundColor;

  /// The foreground color used to indicate progress
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    final progressRadians = (1.0 - value) * 2 * math.pi;

    final paint2 = Paint()
      ..color = color
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progressRadians, false, paint2);
  }

  @override
  bool shouldRepaint(PieProgressPainter other) {
    return value != other.value || color != other.color || backgroundColor != other.backgroundColor;
  }
}
