import 'package:challenge/ui/core/ui/button_widget.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  void handleBackClick(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Set up Scaffold and the appBar with custom color.
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 32, 78, 109),
      ),
      body: SafeArea( // Define safe area and then display child widget.
        child: Center(
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
        )
      ),
    );
  }
}