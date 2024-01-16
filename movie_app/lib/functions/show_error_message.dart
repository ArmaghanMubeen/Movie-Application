// Import the material library from the Flutter framework
import 'package:flutter/material.dart';

// Define a function showErrorDialog that takes a BuildContext and errorMessage as parameters
void showErrorDialog(BuildContext context, errorMessage) {
  // Show a dialog using the showDialog function provided by Flutter
  showDialog(
    // Set the context for the dialog
    context: context,
    // Define the dialog using a builder function that returns an AlertDialog
    builder: (BuildContext context) {
      // Return an AlertDialog widget with a title, content, and actions
      return AlertDialog(
        // Set the title of the AlertDialog to 'Error'
        title: const Text('Error'),
        // Set the content of the AlertDialog to the errorMessage passed as a parameter
        content: Text(errorMessage),
        // Define the actions (buttons) for the AlertDialog
        actions: <Widget>[
          // Create a TextButton with an onPressed event that pops the dialog from the navigation stack
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            // Set the child of the TextButton to a Text widget with the label 'OK'
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
