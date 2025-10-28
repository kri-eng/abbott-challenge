import 'package:challenge/ui/core/ui/button_widget.dart';
import 'package:challenge/ui/heart/view_model/heart_view_model.dart';
import 'package:challenge/ui/heart/widgets/percentage_text.dart';
import 'package:challenge/ui/success/widgets/success_screen.dart';
import 'package:flutter/material.dart';


/// A stateful screen that displays the animated heart progress UI.
///
/// The [HeartScreen] serves as the primary view for visualizing the
/// heart fill animation, controlled by the [HeartViewModel].
/// It uses a [ValueListenableBuilder] to listen to percentage updates
/// and reactively rebuild the UI as the heart fills.
///
/// This screen follows the MVVM pattern, where all business logic
/// (e.g., timing, percentage updates) resides in [HeartViewModel],
/// and this class focuses purely on presentation and UI behavior.
class HeartScreen extends StatefulWidget {
  const HeartScreen({super.key});

  @override
  State<HeartScreen> createState() {
    return _HeartScreenState();
  }
}

class _HeartScreenState extends State<HeartScreen> {
  late final HeartViewModel heartVM; // Initialized in initState(), and is a final value.


  @override
  void initState() {  // Initializes the state and ViewModel.
    super.initState();
    heartVM = HeartViewModel();
    heartVM.startCounter();
  }

  @override
  void dispose() {  // Disposes the viewModel properly
    heartVM.dispose();
    super.dispose();
  }

  /// handleNextClick
  ///
  /// Function used to navigate to the Success Screen State.
  /// Invoked when Next Button is clicked.
  void handleNextClick() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => SuccessScreen()
      ),
    );
  }

  /// handleClearClick
  ///
  /// Function used to reset the timer and percentage.
  /// Invoked when Clear Button is clicked.
  void handleClearClick() {}

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(  // ValueListenableBuilder - builds everytime when the value i.e. the percentage changes.
      valueListenable: heartVM.percentage, 
      builder: (context, value, _) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded( // Ensures that Text and Heart Widget stays togather and in bound.
                child: Center(
                  child: PercentageText(amount: value)
                ),
              ),
              Padding(  // Ensures that bottom padding is applied to the buttons.
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
                    const SizedBox(height: 12,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,  // Takes up 85% of the width available.
                      child: ButtonWidget(
                        buttonText: "Next", 
                        onClick: (value != 100) ? null : handleNextClick,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }
}