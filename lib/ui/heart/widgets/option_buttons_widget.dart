import 'package:challenge/ui/core/ui/button_widget.dart';
import 'package:flutter/material.dart';

/// OptionButtonsWidget
/// 
/// OptionButtonWidgte is a widgte that contain sthe buttons i.e. the clear and next as the chidl.
/// The widget was primarairly created in order to refactor the code base in the main file.
/// The widget takes in the current percentage value, and also the callback for each button.
class OptionButtonsWidget extends StatelessWidget {
  const OptionButtonsWidget({super.key, required this.value, required this.handleClearClick, required this.handleNextClick}); // Constructor.

  final int value;
  final void Function() handleClearClick;
  final void Function() handleNextClick;

  @override
  Widget build(BuildContext context) {
    return Padding(  // Ensures that bottom padding is applied to the buttons.
      padding: const EdgeInsetsGeometry.only(bottom: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility( // Maintains the block utilized by the clear button.
            visible: value == 100,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,  // Takes up 85% of the width available.
              child: ButtonWidget(
                buttonText: "Clear", 
                onClick: handleClearClick,
              ),
            ),
          ),
          const SizedBox(height: 12,), // Creates a vertical Gap.
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,  // Takes up 85% of the width available.
            child: ButtonWidget(
              buttonText: "Next", 
              onClick: (value != 100) ? null : handleNextClick,
            ),
          ),
        ],
      ),
    );
  }
}