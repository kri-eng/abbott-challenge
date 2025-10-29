import 'dart:async';
import 'package:challenge/data/services/heart_fill_service.dart';
import 'package:challenge/domain/models/heart_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeartViewModel{
  HeartViewModel({HeartFillService? heartFillService}): _heartFillService = heartFillService ?? HeartFillService() {
    _loadState();
  }

  final ValueNotifier<HeartModel> state = ValueNotifier<HeartModel>(const HeartModel(percentage: 0, timerRunning: false));
  final HeartFillService _heartFillService;

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('percentage', state.value.percentage);
    await prefs.setBool('timerRunning', state.value.timerRunning);
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final percentage = prefs.getInt('percentage') ?? 0;
    final timerRunning = prefs.getBool('timerRunning') ?? false;

    state.value = HeartModel(percentage: percentage, timerRunning: timerRunning);

    if (percentage < 100 && timerRunning) {
      startCounter();
    }
  }

  void startCounter() {
    state.value = state.value.copyWith(timerRunning: true);
    _saveState();

    _heartFillService.startCounter(
     currentPercentage: state.value.percentage,
     onIncrement: (newPercentage) {
       state.value = state.value.copyWith(percentage: newPercentage);
       _saveState();
     },
     onComplete: () {
       pauseCounter();
     },
   );

  }

  void pauseCounter() {
    _heartFillService.stopCounter();
    state.value = state.value.copyWith(timerRunning: false);
    _saveState();
  }

  void resetCounter() {
    _heartFillService.stopCounter();
    state.value = const HeartModel(percentage: 0, timerRunning: false);
    _saveState();
  }

  void pauseAndResumeCounter() {
    if (state.value.timerRunning) {
      pauseCounter();
    } else {
      startCounter();
    }
  }

  void dispose() {
    _heartFillService.dispose();
    state.dispose();
  }
}