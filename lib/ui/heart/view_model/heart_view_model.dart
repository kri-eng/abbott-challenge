import 'dart:async';
import 'package:challenge/domain/models/heart_model.dart';
import 'package:flutter/foundation.dart';

class HeartViewModel{
  
  final ValueNotifier<HeartModel> state = ValueNotifier<HeartModel>(const HeartModel(percentage: 0, timerRunning: false));
  Timer? _timer;

  void startCounter() {
    if (state.value.timerRunning) {
      return;
    } else {
      state.value = state.value.copyWith(timerRunning: true);
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (state.value.percentage < 100) {
          state.value = state.value.copyWith(percentage: state.value.percentage + 10);
        } else {
          pauseCounter();
        }
      });
    }
  }

  void pauseCounter() {
    _timer?.cancel();
    state.value = state.value.copyWith(timerRunning: false);
  }

  void resetCounter() {
    _timer?.cancel();
    state.value = const HeartModel(percentage: 0, timerRunning: false);
  }

  void pauseAndResumeCounter() {
    if (state.value.timerRunning) {
      pauseCounter();
    } else {
      startCounter();
    }
  }

  void dispose() {
    _timer?.cancel();
    state.dispose();
  }
}