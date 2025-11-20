import 'dart:async';
import 'dart:ui';

import 'package:challenge/domain/interfaces/heart_fill_service_interface.dart';

/// HeartFillService
///
/// Service meant for handling the increment of percentage
/// utilized in [HeartViewModel]. The service takes in the
/// currentPercentage, an onIncrement Callback and onComplete callback.
/// The service also implements stopCounter and dispose functionality.
/// 
/// UPDATE: The service now extends a HeartFillServiceInterface
/// The service implements the methods defined in the interface.
class HeartFillService implements HeartFillServiceInterface {
  Timer? _timer;

  @override
  void startCounter({
    required int currentPercentage,
    required Function(int newPercentage) onIncrement,
    required VoidCallback onComplete,
  }) {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) { // Ticks every second
      final newPercentage = currentPercentage + (timer.tick * 10);  // Increments percentage
    
      if (newPercentage < 100) {  // Ends the timer if percentage is 100.
        onIncrement(newPercentage);   // Callback to set the new percentage value.
      } else {
        onIncrement(100); // Sets the latest percentage
        onComplete(); // calls the callback.
        timer.cancel(); // cancls timer.
      }
    });
  }
  
  @override
  void stopCounter() {  // Utilized to cancel the current timer.
    _timer?.cancel();
  }
  
  /// Method needs to be called in order to dispose whenever [HeartFillService] is utilized
  @override
  void dispose() {  // Cancels any running timer.
    _timer?.cancel();
  }
}
