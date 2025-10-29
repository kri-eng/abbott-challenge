// heart_fill_service.dart
import 'dart:async';
import 'dart:ui';

class HeartFillService {
 Timer? _timer;
  /// Starts a timer that calls the provided callback every second
 /// with the next percentage value (incremented by 10)
 void startCounter({
   required int currentPercentage,
   required Function(int newPercentage) onIncrement,
   required VoidCallback onComplete,
 }) {
   _timer?.cancel();
  
   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
     final newPercentage = currentPercentage + (timer.tick * 10);
    
     if (newPercentage < 100) {
       onIncrement(newPercentage);
     } else {
       onIncrement(100);
       onComplete();
       timer.cancel();
     }
   });
 }
  /// Stops the current increment timer
 void stopCounter() {
   _timer?.cancel();
 }
  /// Cleanup method to cancel any running timers
 void dispose() {
   _timer?.cancel();
 }
}
