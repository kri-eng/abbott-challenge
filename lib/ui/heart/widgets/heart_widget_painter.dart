import 'package:flutter/material.dart';

/// HeartWidgetPainter
///
/// The main class that layouts the shape of the heart widget.
/// The class extends CustomPainter which gives the class funciton like paint and shouldReplace.
/// allowing for programmatical class creation and also filling elements.
/// 
/// It tales in the current percentage and utilizes it to display the fille dportion accordingly.
class HeartWidgetPainter extends CustomPainter {

  HeartWidgetPainter({required this.percentage}); // Constructor.

  final int percentage; // The current heart percentage
  final Color fillColor = Color.fromARGB(255, 64, 15, 100);
  final Color bgColor = Color.fromARGB(255, 220, 220, 220);
  final Color borderColor = Color.fromARGB(255, 0, 0, 0);
  Path? path; // Making path visible.

  // _buildHeartPath
  //
  // Function to build the path in the shape of heart
  // which will eb utilized later in order to display the heart on canvas.
  // The fucntion takes in the aaviable width and the height and displays path accordingly.
  Path _buildHeartPath(double width, double height) {
    final Path path = Path();
    
    path.moveTo(0.5 * width, height * 0.40);  // Starting point of path
    path.cubicTo(0.70 * width, height * 0.05, 1.30 * width, height * 0.6, 0.5 * width, height); // curve from starting point to bottom of hart
    path.cubicTo(-0.30 * width, height * 0.6, 0.30 * width, height * 0.05, 0.5 * width, height * 0.40); // curve from bottom point to starting point of hear
    path.close(); // close the path
    
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {    
    final Paint bgPaint = Paint();  // Utilized to paint the bgColor.
    bgPaint.color = bgColor;
    bgPaint.style = PaintingStyle.fill;

    final Paint fillPaint = Paint();  // Utilized to paint the fill Color.
    fillPaint.color = fillColor;
    fillPaint.style = PaintingStyle.fill;

    path = _buildHeartPath(size.width, size.height); // Get the path and draw it on canvas.
    canvas.drawPath(path!, bgPaint);
    canvas.save();  // Save the current canvas.
    
    // Calculations for the heart sahpe, utlized by the shaow and also the fill.
    // The heart spans from height * 0.05 (top) to height * 1.0 (bottom)
    double heartTop = size.height * 0.28;
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
    
    // Add Shadow
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
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)); // Allows for the shadowPaint to match the
    // shadow inside of the challenge - gives more depth at the top then at the bottom.
    
    // Draw the heart border with gradient shadow
    final shadowPaint = Paint();
    shadowPaint.shader = gradientShader;
    shadowPaint.style = PaintingStyle.stroke;
    shadowPaint.strokeWidth = 5;
    shadowPaint.maskFilter = MaskFilter.blur(BlurStyle.normal, 4);
    
    canvas.drawPath(path!, shadowPaint);  // Draw the current shadow restore the canves and save.
    canvas.restore();
    canvas.save();

    // Add filled portion.
    // Finally clip a rect that displays the filled portion, allowing for dynamic update to the heart.
    canvas.clipRect(Rect.fromLTWH(
      0,
      clipTop, 
      size.width,
      fillHeight,
    ));
    canvas.drawPath(path!, fillPaint);  // Draw the filled portion.
    canvas.restore();  // Restore the canvas.
  } 

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this; // Return false if no value sin the delegates have changed.
  }
}