import 'package:challenge/ui/core/ui/button_widget.dart';
import 'package:challenge/ui/heart/view_model/heart_view_model.dart';
import 'package:challenge/ui/heart/widgets/percentage_text.dart';
import 'package:flutter/material.dart';

class HeartScreen extends StatefulWidget {
  const HeartScreen({super.key});

  @override
  State<HeartScreen> createState() {
    return _HeartScreenState();
  }
}

class _HeartScreenState extends State<HeartScreen> {
  late final HeartViewModel heartVM;

  @override
  void initState() {
    super.initState();
    heartVM = HeartViewModel();
    heartVM.startCounter();
  }

  @override
  void dispose() {
    heartVM.dispose();
    super.dispose();
  }

  void handleNextClick() {}

  void handleClearClick() {}

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: heartVM.percentage, 
      builder: (context, value, _) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: PercentageText(amount: value)
                ),
              ),
              Padding(
                padding: const EdgeInsetsGeometry.only(bottom: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (value == 100)
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: ButtonWidget(
                          buttonText: "Clear", 
                          onClick: handleClearClick,
                        ),
                      ),
                    const SizedBox(height: 12,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
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