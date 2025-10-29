class HeartModel {
  const HeartModel({required this.percentage, required this.timerRunning});

  final int percentage;
  final bool timerRunning;

  HeartModel copyWith({int? percentage, bool? timerRunning}) {
    return HeartModel(
      percentage: percentage ?? this.percentage, 
      timerRunning: timerRunning ?? this.timerRunning
    );
  }
}