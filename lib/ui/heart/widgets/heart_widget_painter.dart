import 'package:flutter/material.dart';

class HeartWidgetPainter extends CustomPainter {

  final int percentage;
  final Color fillColor = Color.fromARGB(255, 64, 15, 100);
  final Color bgColor = Color.fromARGB(255, 220, 220, 220);
  final Color borderColor = Color.fromARGB(255, 0, 0, 0);
  Path? path;

  HeartWidgetPainter({required this.percentage});

  Path _buildHeartPath(double width, double height) {
    final Path path = Path();
    
    path.moveTo(0.5 * width, height * 0.40);
    path.cubicTo(0.70 * width, height * 0.05, 1.30 * width, height * 0.6, 0.5 * width, height);
    path.cubicTo(-0.30 * width, height * 0.6, 0.30 * width, height * 0.05, 0.5 * width, height * 0.40);
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

    canvas.save();
    
    // The heart spans from height * 0.05 (top) to height * 1.0 (bottom)
    double heartTop = size.height * 0.26;
    double heartBottom = size.height;
    double heartHeight = heartBottom - heartTop;
    
    // Calculate how much of the heart to fill from bottom
    double fillHeight = heartHeight * (percentage / 100);
    double clipTop = heartBottom - fillHeight;
    
    // Clip to only the unfilled area (above the fill line)
    canvas.clipPath(path!);
    canvas.clipRect(Rect.fromLTWH(
      0,
      0,
      size.width,
      clipTop
    ));
    
    // Create gradient shader from top to bottom (dark to transparent)
    final gradientShader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black.withOpacity(0.3),
        Colors.black.withOpacity(0.1),
        Colors.black.withOpacity(0.0),
      ],
      stops: [0.0, 0.5, 1.0],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    
    // Draw the heart border with gradient shadow
    final shadowPaint = Paint();
    shadowPaint.shader = gradientShader;
    shadowPaint.style = PaintingStyle.stroke;
    shadowPaint.strokeWidth = 5;
    shadowPaint.maskFilter = MaskFilter.blur(BlurStyle.normal, 4);
    
    canvas.drawPath(path!, shadowPaint);
    canvas.restore();

    canvas.save();
    canvas.clipRect(Rect.fromLTWH(
      0,
      clipTop, 
      size.width,
      fillHeight
    ));
    canvas.drawPath(path!, fillPaint);
    canvas.restore(); 
  } 

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}