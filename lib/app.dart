import 'package:challenge/ui/heart/widgets/heart_screen.dart';
import 'package:flutter/material.dart';

/// The root widget of the Flutter application.
///
/// The [MyApp] class defines the top-level configuration and layout
/// of the application. It sets up a [MaterialApp] with global theme.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Set up Material App
      title: 'Abbott Challenge', 
      home: HeartScreen()
    );
  }
}