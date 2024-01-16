// Importing the necessary packages
// Flutter Material package for UI components
import 'package:flutter/material.dart';
// Google Fonts package for custom fonts
import 'package:google_fonts/google_fonts.dart';

// Creating a custom text widget
class CustomText extends StatelessWidget {
  // Declaring variables for text, color, font size, and font weight
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  // Constructor for the custom text widget
  const CustomText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);

  // Build method for rendering the custom text widget
  @override
  Widget build(BuildContext context) {
    // Returning a Text widget with specified text and style
    return Text(
      text,
      // Applying the Roboto font from Google Fonts with optional parameters
      style: GoogleFonts.roboto(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
