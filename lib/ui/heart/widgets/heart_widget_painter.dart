import 'package:flutter/material.dart';

class HeartWidgetPainter extends CustomPainter {

  final int percentage;
  final Color fillColor = Color.fromARGB(255, 64, 15, 100);
  final Color bgColor = Color.fromARGB(255, 217, 217, 217);
  final Color borderColor = Color.fromARGB(255, 0, 0, 0);
  Path? path;

  HeartWidgetPainter({required this.percentage});

  Path _buildHeartPath(double width, double height) {
    final Path path = Path();
    
    path.moveTo(0.5 * width, height * 0.40);
    path.cubicTo(0.70 * width, height * 0.05, 1.30 * width, height * 0.6, 0.5 * width, height);
    path.moveTo(width * 0.5, height * 0.40);
    path.cubicTo(0.30 * width, height * 0.05, -0.30 * width, height * 0.6, 0.5 * width, height);
    path.close();
    
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {    
    final Paint bgPaint = Paint();
    bgPaint.color = bgColor;
    bgPaint.style = PaintingStyle.fill;

    final Paint fillPaint = Paint();
    fillPaint.color = fillColor;
    fillPaint.style = PaintingStyle.fill;

    path = _buildHeartPath(size.width, size.height);
 
    canvas.drawPath(path!, bgPaint);
  } 

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}