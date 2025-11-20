import 'package:challenge/data/repositories/heart_fill_repository.dart';
import 'package:challenge/ui/heart/view_model/heart_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../fakes/fake_heart_fill_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // Initzlies testing framework.

  late HeartViewModel heartViewModel; // Initializes the heartViewModel
  late FakeHeartFillService fakeHeartFillService; // Intizlies the fake Service.

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    fakeHeartFillService = FakeHeartFillService();
    heartViewModel = HeartViewModel(
      heartFillRepo: HeartFillRepository(
        heartFillService: fakeHeartFillService
      )
    );
  });

  tearDown(() {
    heartViewModel.dispose();
  });

  /// Test - 1:
  /// Checks if the state is intialized correctly.
  test('Test - 1: Initial state is correct', () async {
    await Future.delayed(Duration.zero);
    
    expect(heartViewModel.state.value.percentage, 0);
    expect(heartViewModel.state.value.timerRunning, false);
  });

  /// Test - 2:
  /// Checks if the state counter sets the running timer and the timerRunngin flag to true.
  test('Test - 2: Start counter sets timerRunning to true', () async {
    await Future.delayed(Duration.zero);
    
    heartViewModel.startCounter();
    await Future.delayed(Duration.zero);
    
    expect(heartViewModel.state.value.timerRunning, true);
    expect(fakeHeartFillService.isRunning, true);
  });

  /// Test - 3:
  /// Checks if the state counter when called twice
  /// sets the running timer and time accordingly. The test also
  /// checks for counter value and makes sure no inconsistent behavior occurs.
  test('Test - 3: Start counter called twice', () async {
    await Future.delayed(Duration.zero);
    
    heartViewModel.startCounter();
    fakeHeartFillService.onIncrement?.call(40);
    await Future.delayed(Duration.zero);
    
    heartViewModel.startCounter();
    await Future.delayed(Duration.zero);
    
    fakeHeartFillService.onIncrement?.call(60);
    await Future.delayed(Duration.zero);

    expect(heartViewModel.state.value.percentage, 60);
    expect(heartViewModel.state.value.timerRunning, true);
    expect(fakeHeartFillService.isRunning, true);
  });

  /// Test - 4
  /// 
  /// The test makes sure the incrementing the percentage is happen consistently.
  test('Test - 4: Increment updates percentage', () async {
    await Future.delayed(Duration.zero);
    
    heartViewModel.startCounter();
    fakeHeartFillService.onIncrement?.call(60);
    await Future.delayed(Duration.zero);
    
    expect(heartViewModel.state.value.percentage, 60);
  });

  /// Test - 5
  /// 
  /// The test makes sure that pausing - stops the timer, and changes appropriate flags.
  test('Test - 5: Pause counter stops timer', () async {
    await Future.delayed(Duration.zero);
    
    heartViewModel.startCounter();
    heartViewModel.pauseCounter();
    await Future.delayed(Duration.zero);
    
    expect(heartViewModel.state.value.timerRunning, false);
    expect(fakeHeartFillService.isRunning, false);
  });

  /// Test - 6
  /// 
  /// The test makes sure reset counetr - sets the state to intial state.
  test('Test - 6: Reset counter resets to initial state', () async {
    await Future.delayed(Duration.zero);
    
    heartViewModel.startCounter();
    fakeHeartFillService.onIncrement?.call(70);
    await Future.delayed(Duration.zero);
    
    expect(heartViewModel.state.value.percentage, 70);
    expect(heartViewModel.state.value.timerRunning, true);

    heartViewModel.resetCounter();
    await Future.delayed(Duration.zero);
    
    expect(heartViewModel.state.value.percentage, 0);
    expect(heartViewModel.state.value.timerRunning, false);
  });

  /// Test - 7
  /// 
  /// The test check for pauseAndResumeCounter, making sure that
  /// toggaling between values results in proper flag association.
  test('Test - 7: Toggle pauses when running', () async {
    await Future.delayed(Duration.zero);
    
    heartViewModel.startCounter();
    await Future.delayed(Duration.zero);
    expect(heartViewModel.state.value.timerRunning, true);
    
    heartViewModel.pauseAndResumeCounter();
    await Future.delayed(Duration.zero);
    expect(heartViewModel.state.value.timerRunning, false);

    heartViewModel.pauseAndResumeCounter();
    await Future.delayed(Duration.zero);
    expect(heartViewModel.state.value.timerRunning, true);

    heartViewModel.pauseAndResumeCounter();
    await Future.delayed(Duration.zero);
    expect(heartViewModel.state.value.timerRunning, false);
  });

  /// Test - 8
  /// 
  /// The test check for pauseAndResumeCounter, making sure that
  /// starting the counter first time also sets the timerRunning to true.
  test('Test - 8: Toggle starts when paused', () async {
    await Future.delayed(Duration.zero);
    
    heartViewModel.pauseAndResumeCounter();
    await Future.delayed(Duration.zero);
    
    expect(heartViewModel.state.value.timerRunning, true);
  });

  /// Test - 9
  /// 
  /// The test ensures that state is percisted after the timer is started and incremernt is called.
  test('Test - 9: State persists to SharedPreferences', () async {
    await Future.delayed(Duration.zero);
    
    heartViewModel.startCounter();
    fakeHeartFillService.onIncrement?.call(60);
    await Future.delayed(Duration.zero);
    
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getInt('percentage'), 60);
    expect(prefs.getBool('timerRunning'), true);
  });

  /// Test - 10
  /// 
  /// Makes sure that the state persists even when the timer is paused or resumes.
  /// Apart from this also makes sure proper timer flag is saved.
  test('Test - 10: State persists when timer paused or resumed', () async {
    await Future.delayed(Duration.zero);
    
    heartViewModel.startCounter();
    fakeHeartFillService.onIncrement?.call(60);
    await Future.delayed(Duration.zero);

    heartViewModel.pauseAndResumeCounter();
    await Future.delayed(Duration.zero);
    expect(heartViewModel.state.value.timerRunning, false);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getInt('percentage'), 60);
    expect(prefs.getBool('timerRunning'), false);

    heartViewModel.pauseAndResumeCounter();
    await Future.delayed(Duration.zero);
    expect(heartViewModel.state.value.timerRunning, true);

    expect(prefs.getInt('percentage'), 60);
    expect(prefs.getBool('timerRunning'), true);
  });
}