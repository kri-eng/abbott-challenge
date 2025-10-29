import 'package:challenge/domain/models/heart_model.dart';
import 'package:challenge/ui/heart/view_model/heart_view_model.dart';
import 'package:challenge/ui/heart/widgets/center_widget.dart';
import 'package:challenge/ui/heart/widgets/option_buttons_widget.dart';
import 'package:challenge/ui/success/widgets/success_screen.dart';
import 'package:flutter/material.dart';

/// HeartScreen
/// 
/// The main screen thatdisplays the home screen for the application
/// It displays the heart shape, percentage text and also the buttons to
/// navigate and clear state.
/// 
/// The HeartScreen is kept a Stateful widget, even though the screen
/// does not manage any state - in order to make sure that the
/// dispose method clears the timers successfully, this ensures consistent
/// behavior across the timers.
class HeartScreen extends StatefulWidget {
  const HeartScreen({super.key});

  @override
  State<HeartScreen> createState() => _HeartScreenState();
}

class _HeartScreenState extends State<HeartScreen> {
  late final HeartViewModel heartVM;
  
  @override
  void initState() {
    super.initState();
    heartVM = HeartViewModel(); // Intializes the VM
  }

  @override
  void dispose() {  // Main method to dispose the heartVM - which in turn diposes other timers.
    heartVM.dispose();
    super.dispose();
  }

  /// handleNextClick
  ///
  /// Function used to navigate to the Success Screen State.
  /// Invoked when Next Button is clicked.
  void handleNextClick(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const SuccessScreen() // Push the new screen on top of the current screen.
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold( // Set up Scaffold and the appBar with custom color.
      appBar: AppBar(
        toolbarHeight: 20.0,
        backgroundColor: Color.fromARGB(255, 32, 78, 109),
      ),
      body: SafeArea( // Define safe area and then display child widget.
        child: Center(
          // Contains ValueListneableBuilder as the child, which ensures
          // that whenever the state i.e. percentage or the timer changes.
          // the UI is updated, and replaces necessry changes in the widget tree.
          child: ValueListenableBuilder<HeartModel>(
            valueListenable: heartVM.state,
            builder: (context, state, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Contains the Heart shape clickable widget and the percentage text.
                  CenterWidget(
                    percentage: state.percentage,
                    onTap: heartVM.pauseAndResumeCounter,
                  ),
                  // Contains the two buttons next and clear, whcih manages naviagtion and state.
                  OptionButtonsWidget(
                    value: state.percentage, 
                    handleClearClick: heartVM.resetCounter, 
                    handleNextClick: () {
                      handleNextClick(context);
                    },
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}