import 'package:challenge/domain/interfaces/heart_fill_service_interface.dart';

/// FakeHeartFillService
///
/// The FakeHeartFillService as the name suggest is the servcie to replciate the
/// behavior of the HeartFillService, except for the timer and time related changes.
/// The services maintains two functions startCounter and Stop Counter and makes sure
/// to call increment / complete methods. it also has an iRunning flag, which trakcs if
/// timer is running.
/// 
/// UPDATE: The fake service now implements the HeartFillServiceInterface.
/// The class implements the methods defined the the interface.
class FakeHeartFillService implements HeartFillServiceInterface {
  Function(int)? onIncrement;
  Function()? onComplete;
  bool isRunning = false;

  @override
  void startCounter({ // Starts fake timer and intializes the onIncrement, OnComplete function which will then
                      // be called in the test framework.
    required int currentPercentage,
    required Function(int) onIncrement,
    required Function() onComplete,
  }) {
    this.onIncrement = onIncrement;
    this.onComplete = onComplete;
    isRunning = true;
  }

  @override
  void stopCounter() {  // Stops fake timer and changes the flag.
    isRunning = false;
  }

  // Update: An addition of the dispose method to conform with the contract
  // of interface. The fake service currently has no timers to manage
  // or dispose, so dispose() only resets internal state.
  @override
  void dispose() {
    isRunning = false;
  }
}