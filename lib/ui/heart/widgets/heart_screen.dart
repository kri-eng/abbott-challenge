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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder(
        valueListenable: heartVM.percentage, 
        builder: (context, value, _) {
          return PercentageText(amount: value);
        }
      ),
    );
  }
}