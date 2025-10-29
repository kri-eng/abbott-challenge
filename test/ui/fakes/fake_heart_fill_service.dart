import 'package:challenge/data/services/heart_fill_service.dart';

class FakeHeartFillService extends HeartFillService {
  Function(int)? onIncrement;
  Function()? onComplete;
  bool isRunning = false;

  @override
  void startCounter({
    required int currentPercentage,
    required Function(int) onIncrement,
    required Function() onComplete,
  }) {
    this.onIncrement = onIncrement;
    this.onComplete = onComplete;
    isRunning = true;
  }

  @override
  void stopCounter() {
    isRunning = false;
  }
}