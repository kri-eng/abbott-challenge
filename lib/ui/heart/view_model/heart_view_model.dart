import 'dart:async';
import 'package:challenge/data/repositories/heart_fill_repository.dart';
import 'package:challenge/domain/models/heart_model.dart';
import 'package:flutter/foundation.dart';  

/// HeartViewModel
/// 
/// The main logic behing the funcitonaing of the Heart Screen.
/// The HeartViewModel is responsible for any updates to the UI - regarding
/// percentage change. The HeartViewModal is manually or automatically injected
/// with the HeartFillService. Which is responsible for increments to the percentage
/// and handles the timer logic.
/// 
/// The main responsibility of the HeartViewModel is to save the current state using shared
/// preferences. The VM is also responsible for loading the persisted states at the time of 
/// startup. The VM also implements many other fucntion that are responsible for starting the counter
/// i.e. alerting the service to start the timer, pause counter, reset counter, and pauseAndReset counter - 
/// utlized heavily when tapping heart widget. The HeartViewModal also contains a dispose method.
/// 
/// UPDATE: The HeartViewModel now takes in HeartFillServiceInterface as an argument instead of HeartFillService.
/// This conforms to the interface implementation.
/// 
/// UPDATE 2: The HeartViewModel now uses the HeartFillRepo service. NOTE: This is updated as this was also a mistake 
/// pointed out by the interviewer. Even though not mentioned in the correction by Ryan 
/// on November 20th. I wanted to correct the mistake that I conducted
class HeartViewModel{
  HeartViewModel({HeartFillRepository? heartFillRepo}): _heartFillRepo = heartFillRepo ?? HeartFillRepository() { // Initializes service
    _initVMState();
  }

  final ValueNotifier<HeartModel> state = ValueNotifier<HeartModel>(const HeartModel(percentage: 0, timerRunning: false)); // Creates a value notifier.
  final HeartFillRepository _heartFillRepo; // UPDATE: service interface declaration.

  Future<void> _initVMState() async {
    final storedState = await _heartFillRepo.loadState();
    state.value = storedState;

    if(storedState.timerRunning && storedState.percentage < 100) {
      startCounter();
    }
  }

  // Starts the initial counter
  void startCounter() {
    state.value = state.value.copyWith(timerRunning: true); // Updates the state.value and saves it
    _heartFillRepo.saveState(state.value);

    _heartFillRepo.startCounter( // Calls service in order to start the counter.
     currentPercentage: state.value.percentage,
     onIncrement: (newPercentage) { // OnIncrement callback.
       state.value = state.value.copyWith(percentage: newPercentage);
       _heartFillRepo.saveState(state.value);
     }, 
     onComplete: () { // OnComplete callback.
       pauseCounter();
     },
   );

  }

  // Pause the repo timer.
  void pauseCounter() {
    _heartFillRepo.stopCounter();  // Calls the service to pause counetr, then saves the state of timer.
    state.value = state.value.copyWith(timerRunning: false);
    _heartFillRepo.saveState(state.value);
  }

  // Reset the repo timer, and save the state.
  void resetCounter() {
   _heartFillRepo.stopCounter();  // Calls the service to stop counter and saves the state of percentage and timerRunning.
    state.value = const HeartModel(percentage: 0, timerRunning: false);
    _heartFillRepo.saveState(state.value);
  }

  /// Utilized byt the Gesture Detector in order to pause and resume the timer.
  void pauseAndResumeCounter() {
    if (state.value.timerRunning) {
      pauseCounter();
    } else {
      startCounter();
    }
  }

  // Dispose method in order to dispose the service as well as the current state.
  void dispose() {
    _heartFillRepo.dispose();
    state.dispose();
  }
}