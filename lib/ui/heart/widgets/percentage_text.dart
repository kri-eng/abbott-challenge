import 'package:flutter/material.dart';

class PercentageText extends StatelessWidget {
  
  const PercentageText({super.key, required this.amount});
  
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$amount%",
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}