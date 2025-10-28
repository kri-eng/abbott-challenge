import 'package:flutter/material.dart';

class HeartWidgetPainter extends CustomPainter {

  final int percentage;
  final Color fillColor = Color.fromARGB(255, 64, 15, 100);
  final Color bgColor = Color.fromARGB(255, 217, 217, 217);
  final Color borderColor = Color.fromARGB(255, 0, 0, 0);

  HeartWidgetPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint();
    bgPaint.color = bgColor;
    bgPaint.style = PaintingStyle.fill;

    final fillPaint = Paint();
    fillPaint.color = fillColor;
    fillPaint.style = PaintingStyle.fill;

    final double width = size.width;
    final double height = size.height;

    final Path path = Path();
    path.moveTo(0.5 * width, height * 0.40);
    path.cubicTo(0.85 * width, height * 0.05, 1.30 * width, height * 0.6, 0.5 * width, height);
    path.moveTo(width * 0.5, height * 0.40);
    path.cubicTo(0.15 * width, height * 0.05, -0.30 * width, height * 0.6, 0.5 * width, height);
    
    canvas.drawPath(path, bgPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}