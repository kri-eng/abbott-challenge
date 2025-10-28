import 'package:flutter/material.dart';

/// A stateless widget that displays the current heart fill percentage.
///
/// The [PercentageText] widget renders a numeric percentage value
/// formatted with a trailing percent symbol (`%`).
///
/// Parameters:
/// [amount] - Represents the percentage amount to be displayed on screen.
class PercentageText extends StatelessWidget {
  
  // Creates a Text with (x)% displayed.
  const PercentageText({super.key, required this.amount});
  
  final int amount; // Int amount representing the amount.

  @override
  Widget build(BuildContext context) {
    return Text(
      "$amount%",
      style: TextStyle( // Styling the text with size and weight.
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}