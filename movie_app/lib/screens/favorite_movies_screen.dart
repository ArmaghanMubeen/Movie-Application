// ignore_for_file: use_build_context_synchronously
// The above line disables linting for the use_build_context_synchronously rule.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cine_noir/components/custom_text.dart';
import 'package:cine_noir/components/movie_Item_widget%20.dart';
import 'package:cine_noir/functions/show_error_message.dart';
import 'package:cine_noir/Models/movie_model.dart';
import 'package:cine_noir/Utils/colors.dart';
import 'package:cine_noir/Utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteMoviesScreen extends StatefulWidget {
  const FavoriteMoviesScreen({
    super.key,
  });
  // A stateful widget representing the screen that displays favorite movies.

  @override
  State<FavoriteMoviesScreen> createState() => _FavoriteMoviesScreenState();
  // Creates the mutable state for this widget at a given location in the tree.
}

class _FavoriteMoviesScreenState extends State<FavoriteMoviesScreen> {
  List<Movie>? favoriteMovies;
  // A list to hold the user's favorite movies.

  late List<Movie> fetchedMovies = [];
  // A list to hold the fetched movies.

  @override
  void initState() {
    super.initState();
    // Called when this object is inserted into the tree.
    // Move the fetchFavoriteMovies call outside of the FutureBuilder
    fetchFavoriteMovies();
    // Calls the method to fetch the user's favorite movies.
  }

  Future<void> fetchFavoriteMovies() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Obtain an instance of SharedPreferences.

      List<String> favoriteMovieIds = prefs.getKeys().toList();
      // Get the list of favorite movie IDs from SharedPreferences.

      List<Movie> api1ForTopRatedMovies = await topRatedMovies;
      List<Movie> api2ForTrendingTodayMovies = await trendingToday;
      List<Movie> api3ForTrendingThisWeekMovies = await trendingThisWeek;
      List<Movie> api4ForMoreMovies = await moreMovies;
      // Fetch movies from different APIs.

      List<Movie> allMovies = [
        ...api1ForTopRatedMovies,
        ...api2ForTrendingTodayMovies,
        ...api3ForTrendingThisWeekMovies,
        ...api4ForMoreMovies
      ];
      // Combine movies from different APIs into a single list.

      // Create a set to store unique movie IDs
      Set<int> uniqueMovieIds = {};
      // Initialize a set to store unique movie IDs.

      // Filter out duplicates based on movie ID
      allMovies.removeWhere((movie) {
        final bool isDuplicate = uniqueMovieIds.contains(movie.id);
        uniqueMovieIds.add(movie.id); // Add the movie ID to the set
        return isDuplicate;
      });
      // Remove duplicate movies based on their IDs.

      fetchedMovies.addAll(allMovies);

      favoriteMovies = fetchedMovies
          .where((movie) => favoriteMovieIds.contains('${movie.id}'))
          .toList();
      // Filter out only the favorite movies from the fetched movies.

      setState(() {});
    } catch (error) {
      // Display a user-friendly error message
      showErrorDialog(
          context, 'Error fetching favorite movies. Please try again.');
      // Show an error dialog with a message.
      if (kDebugMode) {
        print('Error fetching favorite movies: $error');
      }
      // Print the error message in debug mode.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      // Set the background color of the screen.

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            // Implement the back button action
            Navigator.pop(context);
            // Navigate back to the previous screen.
          },
        ),
        title: const CustomText(
          text: 'Favourities',
          color: white,
        ),
        centerTitle: true,
        backgroundColor: black, // Set the background color of the app bar
        actions: [
          const Icon(
            Icons.search,
            color: white,
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
      // Scaffold with an app bar containing a back button, title, and search icon.

      body: (favoriteMovies == null)
          ? const Center(child: CircularProgressIndicator())
          : (favoriteMovies!.isEmpty)
              ? const Center(
                  child: CustomText(
                  text: 'You don\'t have any movie in favourities',
                  color: white,
                ))
              : Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),
                  child: MasonryGridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20.w,
                    itemCount: favoriteMovies!.length,
                    itemBuilder: (context, index) {
                      return MovieItemWidget(
                        movie: favoriteMovies![index],
                        forVerticalMovieList: true,
                      );
                    },
                  ),
                ),
      // Display a loading indicator if favoriteMovies is null.
      // Display a message if there are no favorite movies.
      // Display a grid of favorite movies if they exist.
    );
  }
}
