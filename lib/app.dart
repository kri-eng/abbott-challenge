import 'package:challenge/ui/heart/widgets/heart_screen.dart';
import 'package:flutter/material.dart';

/// The root widget of the Flutter application.
///
/// The [MyApp] class defines the top-level configuration and layout
/// of the application. It sets up a [MaterialApp] with global theme,
/// routing, and a default [Scaffold] structure.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Set up Material App
      title: 'Abbott Challenge', 
      home: Scaffold( // Set up Scaffold and the appBar with custom color.
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 32, 78, 109),
        ),
        body: SafeArea( // Define safe area and then display HeartScreen as the child widget.
          child: HeartScreen()
        ),
      ),
    );
  }
}