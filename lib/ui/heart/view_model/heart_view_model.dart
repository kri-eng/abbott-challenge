import 'dart:async';
import 'package:flutter/foundation.dart';

/// A ViewModel class responsible for managing the heart progress logic.
///
/// The [HeartViewModel] controls the progression of a percentage-based
/// counter that represents the fill state of a heart animation or progress UI.
/// It uses a [ValueNotifier] to expose real-time updates to the UI.
class HeartViewModel {
  final ValueNotifier<int> percentage = ValueNotifier<int>(0); // ValueNotifier object for tracking percentage.
  Timer? _timer; // Timer to keep track of time.

  /// startCounter
  /// 
  /// Invoked in order to start the timer.
  /// If percentage is >= 10, the timer will cancel.
  void startCounter() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (percentage.value < 100) {
        percentage.value += 10;
      } else {
        _timer?.cancel();
      }
    });
  }

  /// resetCounter
  /// 
  /// Cancel the timer, and sets percentage value to 0.
  /// INvoked when Clear button is clicked.
  void resetCounter() {
    _timer?.cancel();
    percentage.value = 0;
  }

  /// pauseCounter
  /// 
  /// Cancel the current timer and keep the percentage value
  /// as the last value.
  void pauseCounter() {
    _timer?.cancel();
  }

  /// dispose
  /// 
  /// Called when ViewModel is no longer needed.
  /// Properly cancels the timer and disposes the ValueNotifier.
  void dispose() {
    _timer?.cancel();
    percentage.dispose();
  }
}