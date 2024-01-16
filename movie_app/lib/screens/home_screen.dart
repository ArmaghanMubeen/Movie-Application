// ignore_for_file: library_private_types_in_public_api

// Import necessary packages and files
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cine_noir/screens/favorite_movies_screen.dart';
import 'package:cine_noir/components/horizontal_movie_lister.dart';
import 'package:cine_noir/components/logo.dart';
import 'package:cine_noir/components/vertical_movie_lister.dart';
import 'package:cine_noir/Utils/colors.dart';
import 'package:cine_noir/Utils/constants.dart';

// Define a StatefulWidget for the HomeScreen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// Define the state for the HomeScreen
class _HomeScreenState extends State<HomeScreen> {
  @override
  // Build the UI for the HomeScreen
  Widget build(BuildContext context) {
    return Scaffold(
      // Define the app bar with a menu icon, centered title, and search icon
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
          color: white,
        ),
        centerTitle: true,
        title: const Logo(),
        actions: [
          const Icon(
            Icons.search,
            color: white,
          ),
          SizedBox(
            width: 10.w,
          )
        ],
        backgroundColor: Colors.transparent,
      ),
      // Set the background color of the body to black
      backgroundColor: black,
      // Create a SafeArea with a vertical scrollable SingleChildScrollView
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.w,
              ),
              // Display a horizontal list of top-rated movies
              HorizontalMovieLister(
                movies: topRatedMovies,
                heading: 'Top Rated Movies',
              ),
              SizedBox(
                height: 30.w,
              ),
              // Display a horizontal list of trending movies today
              HorizontalMovieLister(
                movies: trendingToday,
                heading: 'Trending Today',
              ),
              SizedBox(
                height: 30.w,
              ),
              // Display a horizontal list of trending movies this week
              HorizontalMovieLister(
                movies: trendingThisWeek,
                heading: 'Trending This Week',
              ),
              SizedBox(
                height: 30.w,
              ),
              // Display a vertical list of more movies
              VerticalMovieLister(
                movies: moreMovies,
                heading: 'More For You',
              ),
              SizedBox(
                height: 20.w,
              ),
            ],
          ),
        ),
      ),
      // Add a FloatingActionButton to navigate to the FavoriteMoviesScreen
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red.shade600,
        shape: const CircleBorder(), // Set the shape to CircleBorder
        onPressed: () {
          // Navigate to the FavoriteMoviesScreen
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FavoriteMoviesScreen()));
        },
        child: const Icon(
          CupertinoIcons.suit_heart_fill,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }
}
