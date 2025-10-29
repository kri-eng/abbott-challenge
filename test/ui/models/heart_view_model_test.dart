import 'package:challenge/ui/heart/view_model/heart_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../fakes/fake_heart_fill_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late HeartViewModel heartViewModel;
  late FakeHeartFillService fakeHeartFillService;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    fakeHeartFillService = FakeHeartFillService();
    heartViewModel = HeartViewModel(heartFillService: fakeHeartFillService);
  });

  tearDown(() {
    heartViewModel.dispose();
  });

  test('Test - 1: Initial state is correct', () async {
    await Future.delayed(Duration.zero);
    
    expect(heartViewModel.state.value.percentage, 0);
    expect(heartViewModel.state.value.timerRunning, false);
  });

  test('Test - 2: Start counter sets timerRunning to true', () async {
    await Future.delayed(Duration.zero);
    
    heartViewModel.startCounter();
    await Future.delayed(Duration.zero);
    
    expect(heartViewModel.state.value.timerRunning, true);
    expect(fakeHeartFillService.isRunning, true);
  });

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

  test('Test - 4: Increment updates percentage', () async {
    await Future.delayed(Duration.zero);
    
    heartViewModel.startCounter();
    fakeHeartFillService.onIncrement?.call(60);
    await Future.delayed(Duration.zero);
    
    expect(heartViewModel.state.value.percentage, 60);
  });

  test('Test - 5: Pause counter stops timer', () async {
    await Future.delayed(Duration.zero);
    
    heartViewModel.startCounter();
    heartViewModel.pauseCounter();
    await Future.delayed(Duration.zero);
    
    expect(heartViewModel.state.value.timerRunning, false);
    expect(fakeHeartFillService.isRunning, false);
  });

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

  test('Test - 8: Toggle starts when paused', () async {
    await Future.delayed(Duration.zero);
    
    heartViewModel.pauseAndResumeCounter();
    await Future.delayed(Duration.zero);
    
    expect(heartViewModel.state.value.timerRunning, true);
  });

  test('Test - 9: State persists to SharedPreferences', () async {
    await Future.delayed(Duration.zero);
    
    heartViewModel.startCounter();
    fakeHeartFillService.onIncrement?.call(60);
    await Future.delayed(Duration.zero);
    
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getInt('percentage'), 60);
    expect(prefs.getBool('timerRunning'), true);
  });

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
  });

  test('Test - 11: State persists when timer paused or resumed', () async {
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