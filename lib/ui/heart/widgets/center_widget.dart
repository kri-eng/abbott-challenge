import 'package:challenge/ui/heart/widgets/heart_tapable_widget.dart';
import 'package:challenge/ui/heart/widgets/percentage_text.dart';
import 'package:flutter/material.dart';

/// CenterWidget
/// 
/// An Expanded idget that is used to display the heart widget and also the percentage text.
/// The widget is created in order to refactor code for the Heart Screen. The widget takes in 
/// the current percentage and a void funtion in order to display the child. The percentage
/// is utilized by the PercentageText Widget and also the callback function is utilized by the
/// HeartTapableWidget and thisensure that pause and resume of timer is done.
class CenterWidget extends StatelessWidget {
  const CenterWidget({super.key, required this.percentage, required this.onTap});

  final int percentage;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded( // Ensures that Text and Heart Widget stays togather and in bound and takes up the aiable column space.
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox( // Contrainst the size of the heart shape with 85% width and 45% height
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.45,
              child: HeartTapableWidget(  // Conatins the tapable heart widget and gesture control
                percentage: percentage,
                onTap: onTap, // Callback
              ),
            ),
            const SizedBox(height: 15,),
            PercentageText(amount: percentage), // Displays text.
            const SizedBox(height: 60,),
          ],
        ),
      ),
    );
  }
}