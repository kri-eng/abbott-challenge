import 'package:challenge/ui/heart/widgets/heart_tapable_widget.dart';
import 'package:challenge/ui/heart/widgets/percentage_text.dart';
import 'package:flutter/material.dart';

class CenterWidget extends StatelessWidget {
  const CenterWidget({super.key, required this.percentage, required this.onTap});

  final int percentage;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded( // Ensures that Text and Heart Widget stays togather and in bound.
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.45,
              child: HeartTapableWidget(
                percentage: percentage, 
                onTap: onTap,
              ),
            ),
            const SizedBox(height: 15,),
            PercentageText(amount: percentage),
            const SizedBox(height: 60,),
          ],
        ),
      ),
    );
  }
}