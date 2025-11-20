import 'dart:ui';
import 'package:challenge/data/services/heart_fill_service.dart';
import 'package:challenge/domain/interfaces/heart_fill_service_interface.dart';
import 'package:challenge/domain/models/heart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// HeartFillRepository
/// 
/// The following class is a repository layer betwen the service layer as well as the
/// view models. The repo layer here handles the storing as well as loading of the persisted state
/// values.
/// 
/// NOTE: This is updated as this was also a mistake pointed out by the interviewer. Even
/// though not mentioned in the correct by Ryan on November 20th. I wanted to correct the mistake
/// that I conducted
class HeartFillRepository {
  
  HeartFillRepository({HeartFillServiceInterface? heartFillService}): _heartFillService = heartFillService ?? HeartFillService();

  final HeartFillServiceInterface _heartFillService;

  // Load Timer Percentage.
  Future<HeartModel> loadState() async {
    final prefs = await SharedPreferences.getInstance();  // Get the current SP instance and gets key-value from it.
    final percentage = prefs.getInt('percentage') ?? 0;
    final timerRunning = prefs.getBool('timerRunning') ?? false;

    return HeartModel(percentage: percentage, timerRunning: timerRunning); // Creates a HeartModel state value for notifier.
  }

  // Save Timer stats.
  Future<void> saveState(HeartModel currentHeartStatus) async {
    final prefs = await SharedPreferences.getInstance();  // Get the current SP instance and saves key-value in it.
    await prefs.setInt('percentage', currentHeartStatus.percentage);
    await prefs.setBool('timerRunning', currentHeartStatus.timerRunning);
  }

  // Start Timer.
  void startCounter({
    required int currentPercentage,
    required Function(int newPercentage) onIncrement,
    required VoidCallback onComplete,
  }) {
    _heartFillService.startCounter(currentPercentage: currentPercentage, onIncrement: onIncrement, onComplete: onComplete);
  }

  // Pause Timer.
  void stopCounter() {
    _heartFillService.stopCounter();
  }

  // Dispose the Timers properly.
  void dispose() {
    _heartFillService.dispose();
  }
}