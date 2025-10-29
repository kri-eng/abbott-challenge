import 'package:challenge/domain/models/heart_model.dart';

import 'package:challenge/ui/heart/view_model/heart_view_model.dart';
import 'package:challenge/ui/heart/widgets/center_widget.dart';

import 'package:challenge/ui/heart/widgets/option_buttons_widget.dart';
import 'package:challenge/ui/success/widgets/success_screen.dart';

import 'package:flutter/material.dart';


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
    heartVM = HeartViewModel();
  }

  @override
  void dispose() {
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
        builder: (ctx) => const SuccessScreen()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold( // Set up Scaffold and the appBar with custom color.
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 32, 78, 109),
      ),
      body: SafeArea( // Define safe area and then display child widget.
        child: Center(
          child: ValueListenableBuilder<HeartModel>(
            valueListenable: heartVM.state,
            builder: (context, state, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CenterWidget(
                    percentage: state.percentage,
                    onTap: heartVM.pauseAndResumeCounter,
                  ),
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