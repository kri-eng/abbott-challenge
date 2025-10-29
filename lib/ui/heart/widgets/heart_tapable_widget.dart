import 'package:challenge/ui/heart/widgets/heart_widget_painter.dart';
import 'package:flutter/material.dart';

class HeartTapableWidget extends StatefulWidget {
  const HeartTapableWidget({super.key, required this.percentage, required this.onTap});

  final int percentage;
  final void Function() onTap;

  @override
  State<HeartTapableWidget> createState() {
    return _HeartTapableWidgetState();
  }
}

class _HeartTapableWidgetState extends State<HeartTapableWidget> {
  final GlobalKey _widgetKey = GlobalKey();
  late HeartWidgetPainter painter;
    
  @override
  Widget build(BuildContext context) {
    final painter = HeartWidgetPainter(percentage: widget.percentage);

    return GestureDetector(
      onTapDown: (details) {
        final renderBox = _widgetKey.currentContext!.findRenderObject() as RenderBox;
        final localPos = renderBox.globalToLocal(details.globalPosition);

        if (painter.path != null && painter.path!.contains(localPos)) {
          widget.onTap();
        }
      },
      child: CustomPaint(
        key: _widgetKey,
        painter: painter,
        size: Size(MediaQuery.of(context).size.width * 0.80, MediaQuery.of(context).size.height * 0.40),
      ),
    );
  }
}