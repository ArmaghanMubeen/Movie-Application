// Importing necessary Flutter packages and custom components
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cine_noir/components/custom_text.dart';
import 'package:cine_noir/Utils/colors.dart';

// Creating a custom widget for displaying movie properties in the movie detail screen
class WidgetForDisplayingMoviePropertiesInMovieDetailScreen
    extends StatelessWidget {
  // Declaring variables to hold data for the widget
  final String upperText;
  final String lowerText;
  final IconData iconData;
  final Color iconColor;

  // Constructor to initialize the widget with required data
  const WidgetForDisplayingMoviePropertiesInMovieDetailScreen(
      {super.key,
      required this.upperText,
      required this.lowerText,
      required this.iconData,
      required this.iconColor});

  // Building the widget with its UI components
  @override
  Widget build(BuildContext context) {
    // Main column containing rows for displaying movie properties
    return Column(
      children: [
        // First row displaying an icon and upper text
        Row(
          children: [
            // Icon representing the movie property
            Icon(
              iconData,
              color: iconColor,
              size: 20.sp,
            ),
            // Container holding custom text for upper text
            Container(
                padding: const EdgeInsets.only(left: 10),
                child: CustomText(
                  text: upperText,
                  fontSize: 14.sp,
                  color: white,
                  fontWeight: FontWeight.w600,
                ))
          ],
        ),
        // Adding a vertical gap between the rows
        SizedBox(
          height: 7.w,
        ),
        // Container holding custom text for lower text
        Container(
            padding: EdgeInsets.only(left: 10.w),
            child: CustomText(
              text: lowerText,
              fontSize: 12.sp,
              color: grey.shade400,
            )),
      ],
    );
  }
}
