// Import necessary packages for Flutter development
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cine_noir/components/custom_text.dart';
import 'package:cine_noir/Utils/colors.dart';

// Define a custom widget class named HeadingForMovieLister, which extends StatelessWidget
class HeadingForMovieLister extends StatelessWidget {
  // Declare a final variable 'heading' of type String, which will store the heading text
  final String heading;

  // Constructor for the class, taking a key parameter (super.key) and a required heading parameter
  const HeadingForMovieLister({super.key, required this.heading});

  // Override the build method to define the UI structure of the widget
  @override
  Widget build(BuildContext context) {
    // Return a Padding widget containing a Column with specific styling
    return Padding(
      // Apply left padding using the ScreenUtil library to make it responsive
      padding: EdgeInsets.only(left: 10.w),
      // Define a Column with crossAxisAlignment set to CrossAxisAlignment.start
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Create a Row widget to display the heading along with a decorative line
          Row(
            children: [
              // Create a vertical line (Container) with specific height, width, and color
              Container(
                height: 20.sp,
                width: 2.5.sp,
                // Use the grey shade 700 color from the imported color utility
                color: grey.shade700,
              ),
              // Add a horizontal space using SizedBox
              SizedBox(
                width: 7.w,
              ),
              // Display the heading text using the CustomText widget with specified properties
              CustomText(
                  text: heading,
                  fontSize: 17.sp,
                  // Use the white color from the imported color utility
                  color: white,
                  fontWeight: FontWeight.bold)
            ],
          ),
          // Add vertical spacing using SizedBox after the Row
          SizedBox(
            height: 15.w,
          ),
        ],
      ),
    );
  }
}
