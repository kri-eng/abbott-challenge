import 'package:challenge/ui/heart/widgets/heart_widget_painter.dart';
import 'package:flutter/material.dart';

/// HeartTapableWidget
/// 
/// One of the core and imporant widget in order to allow Gesture Dectection for the heart.
/// This allows for pausing and resuming the timer/percentage change. The Widget takes in the the 
/// current percentage and a callback which will be called when gesture like onTap is dected.
/// 
/// The widget was intially a statefulWidget, which persisted the global key, however LayoutBuilder was
/// utlized as a cleaner workaround the issue.
/// 
/// 
class HeartTapableWidget extends StatelessWidget {
  const HeartTapableWidget({super.key, required this.percentage, required this.onTap}); // Constructor.

  final int percentage;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder( // Prvoides the context to generate the renderBox.
      builder: (context, constraints) {
        final painter = HeartWidgetPainter(percentage: percentage); // Intializes the painter.
        
        return GestureDetector( // Returns a GestureDetector Widget
          onTapDown: (details) {  // Activates on tap down.
            final renderBox = context.findRenderObject() as RenderBox;
            final localPos = renderBox.globalToLocal(details.globalPosition); // Gets the local coordinates.

            if (painter.path != null && painter.path!.contains(localPos)) { // If local coordinates in the current path of painter
              onTap();  // then activate the callback.
            } 
          },
          child: CustomPaint( // Has CustomPaint - HeartWidgetPainter as the child.
            painter: painter,
            size: Size( // Size restricted to match the dimension of challenge.
              MediaQuery.of(context).size.width * 0.80, 
              MediaQuery.of(context).size.height * 0.40
            ),
          ),
        );
      },
    );
  }
}