// Import necessary Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Import custom files
import 'package:cine_noir/Screens/home_screen.dart';
import 'package:cine_noir/Utils/colors.dart';

// Entry point of the application
void main() {
  // Run the app by calling the MyApp widget
  runApp(const MyApp());
}

// MyApp class, a stateless widget representing the entire application
class MyApp extends StatelessWidget {
  // Constructor for MyApp widget with a constant key
  const MyApp({super.key});

  // Build method to create the widget tree for the app
  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil to set up the screen size and text adaptation
    return ScreenUtilInit(
      designSize: const Size(360, 720),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use the library outside ScreenUtilInit context
      builder: (_, child) {
        // Create MaterialApp widget with a custom theme and HomeScreen as the initial screen
        return MaterialApp(
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSwatch().copyWith(primary: red, secondary: red),
          ),
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        );
      },
      // HomeScreen widget as a child in case builder is not executed
      child: const HomeScreen(),
    );
  }
}
