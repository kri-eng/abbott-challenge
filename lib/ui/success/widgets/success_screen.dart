import 'package:challenge/ui/core/ui/button_widget.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  void handleBackClick(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Text(
                "SUCCESS!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ),
          Padding(  // Ensures that bottom padding is applied to the buttons.
            padding: const EdgeInsetsGeometry.only(bottom: 40),
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,  // Takes up 85% of the width available.
                child: ButtonWidget(
                  buttonText: "Back", 
                  onClick: () {
                    handleBackClick(context);
                  }
                ),
            ),
          ),
        ],
      ),
    );
  }
}