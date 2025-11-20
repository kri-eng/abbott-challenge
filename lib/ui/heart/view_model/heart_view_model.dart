import 'dart:async';
import 'package:challenge/data/services/heart_fill_service.dart';
import 'package:challenge/domain/interfaces/heart_fill_service_interface.dart';
import 'package:challenge/domain/models/heart_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
class HeartViewModel{
  HeartViewModel({HeartFillServiceInterface? heartFillService}): _heartFillService = heartFillService ?? HeartFillService() { // Initializes service
    _loadState(); // Loads the persisted state
  }

  final ValueNotifier<HeartModel> state = ValueNotifier<HeartModel>(const HeartModel(percentage: 0, timerRunning: false)); // Creates a value notifier.
  final HeartFillServiceInterface _heartFillService; // UPDATE: service interface declaration.

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();  // Get the current SP instance and saves key-value in it.
    await prefs.setInt('percentage', state.value.percentage);
    await prefs.setBool('timerRunning', state.value.timerRunning);
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();  // Get the current SP instance and gets key-value from it.
    final percentage = prefs.getInt('percentage') ?? 0;
    final timerRunning = prefs.getBool('timerRunning') ?? false;

    state.value = HeartModel(percentage: percentage, timerRunning: timerRunning); // Creates a HeartModel state value for notifier.

    if (percentage < 100 && timerRunning) { // If the app was closed and the timer was still runnning, when the app is
      startCounter();                       // opened the timer will keep on running.
    }
  }

  // Starts the initial counter
  void startCounter() {
    state.value = state.value.copyWith(timerRunning: true); // Updates the state.value and saves it
    _saveState();

    _heartFillService.startCounter( // Calls service in order to start the counter.
     currentPercentage: state.value.percentage,
     onIncrement: (newPercentage) { // OnIncrement callback.
       state.value = state.value.copyWith(percentage: newPercentage);
       _saveState();  
     }, 
     onComplete: () { // OnComplete callback.
       pauseCounter();
     },
   );

  }

  void pauseCounter() {
    _heartFillService.stopCounter();  // Calls the service to pause counetr, then saves the state of timer.
    state.value = state.value.copyWith(timerRunning: false);
    _saveState();
  }

  void resetCounter() {
    _heartFillService.stopCounter();  // Calls the service to stop counter and saves the state of percentage and timerRunning.
    state.value = const HeartModel(percentage: 0, timerRunning: false);
    _saveState();
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
    _heartFillService.dispose();
    state.dispose();
  }
}