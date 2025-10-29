/// HeartModel
/// 
/// A model class that structures the necessary data points
/// utlizes in the application. The app conatins to major value
/// utilizes through out - the percentage and a flag to check if
/// timer is running. The [HeartModel] structures this data and 
/// also provides additional functionality which will be
/// helful in accordance with [ValueNotifier]
class HeartModel {
  const HeartModel({required this.percentage, required this.timerRunning}); // Initializes the values.

  final int percentage;
  final bool timerRunning;

  // Utilized in order to return a new instance of the HeartModel class.
  // This in accordance with ValueNotifier ensure UI stays updated, whenever
  // changes occur.
  HeartModel copyWith({int? percentage, bool? timerRunning}) {
    return HeartModel(
      percentage: percentage ?? this.percentage, 
      timerRunning: timerRunning ?? this.timerRunning
    );
  }
}