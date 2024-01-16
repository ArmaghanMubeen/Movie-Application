// Importing the Flutter framework for building UIs
import 'package:flutter/cupertino.dart';

// Importing a third-party package for responsive UI design
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Importing custom text component
import 'package:cine_noir/components/custom_text.dart';

// Importing custom colors utility
import 'package:cine_noir/Utils/colors.dart';

// Defining a Flutter widget class named HeadingForMovieDetailScreen
class HeadingForMovieDetailScreen extends StatelessWidget {
  // Declaring a final variable 'heading' of type String for the widget
  final String heading;

  // Constructor for the HeadingForMovieDetailScreen class
  const HeadingForMovieDetailScreen({super.key, required this.heading});

  // Build method to create the UI for the widget
  @override
  Widget build(BuildContext context) {
    // Returning a Padding widget to add left padding to the child widget
    return Padding(
      // Setting the left padding using the responsive width value
      padding: EdgeInsets.only(left: 10.w),

      // Child widget is a CustomText component
      child: CustomText(
        // Setting the text content to the provided 'heading'
        text: heading,

        // Setting the font size using responsive screen height value
        fontSize: 15.sp,

        // Setting the text color using a predefined color from custom colors utility
        color: white,

        // Setting the font weight for the text
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
