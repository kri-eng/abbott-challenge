import 'package:flutter/material.dart';

/// A reusable, pre-styled elevated button used throughout the app.
///
/// This widget provides a consistent look and feel for all primary
/// action buttons. It wraps Flutter's [ElevatedButton] with custom
/// styling such as reduced rounded corners, reduced vertical padding, and
/// a uniform accent color.
///
/// Parameters:
/// [buttonText] → the label displayed on the button  
/// [onClick] → the callback function triggered when the button is pressed  
class ButtonWidget extends StatelessWidget {

  /// Creates a standardized button with uniform style.
  const ButtonWidget({super.key, required this.buttonText, required this.onClick});
  
  final String buttonText; // The text displayed inside the button.
  final void Function()? onClick; // The callback function executed when button is tapped, can also be null.

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick, // If onClick is null, button will be disabled.
      style: ElevatedButton.styleFrom( // Adding padding, shape and background color.
        minimumSize: Size(0, 0), // Removing default elevated button size.
        padding: const EdgeInsets.symmetric(
          vertical: 7,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Color.fromARGB(255, 51, 117, 184),
      ),
      child: Text(
        buttonText,
        style: TextStyle( // Styling the Text inside the button.
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}