import 'dart:async';
import 'package:flutter/foundation.dart';

class HeartViewModel {
  final ValueNotifier<int> percentage = ValueNotifier<int>(0);
  Timer? _timer;

  void startCounter() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (percentage.value < 100) {
        percentage.value += 10;
      } else {
        _timer?.cancel();
      }
    });
  }

  void dispose() {
    _timer?.cancel();
    percentage.dispose();
  }
}