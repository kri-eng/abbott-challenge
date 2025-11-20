import 'package:flutter/foundation.dart';

/// HeartFillServiceInterface:
/// 
/// Defines the contract for the startCounter, stopCounter and dispose method.
/// The interface will be extended in main HeartFillService as well as the
/// mock/fake heart fill service class.
/// 
/// Defines three methods - startCounter(with three arguments), stopCounter,
/// and finally a dispose method.
abstract class HeartFillServiceInterface {
  
  void startCounter({
    required int currentPercentage,
    required Function(int newPercentage) onIncrement,
    required VoidCallback onComplete,
  });

  void stopCounter();

  void dispose();
}