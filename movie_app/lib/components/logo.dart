// Importing the material library from Flutter
import 'package:flutter/material.dart';

// Defining a new Flutter widget called Logo that extends StatelessWidget
class Logo extends StatelessWidget {
  // Constructor for the Logo widget, taking a key as a parameter (not using it in this case)
  const Logo({super.key});

  // Override the build method to define the structure of the widget
  @override
  Widget build(BuildContext context) {
    // Return a RichText widget, allowing different styles within a single text widget
    return RichText(
      // Define the text to be displayed using TextSpan
      text: const TextSpan(
        // List of children TextSpan widgets for different parts of the text
        children: [
          // First part of the text: 'Ciné' with specific style settings
          TextSpan(
            text: 'Ciné',
            style: TextStyle(
                color: Colors.red, // Text color set to red
                fontSize: 25, // Font size set to 25
                fontWeight: FontWeight.bold, // Text weight set to bold
                letterSpacing: .5), // Spacing between letters set to 0.5
          ),
          // Second part of the text: 'Noir' with different style settings
          TextSpan(
            text: 'Noir',
            style: TextStyle(
                color: Colors.white, // Text color set to white
                fontSize: 25, // Font size set to 25
                fontWeight: FontWeight.bold, // Text weight set to bold
                letterSpacing: .5), // Spacing between letters set to 0.5
          ),
        ],
      ),
    );
  }
}
