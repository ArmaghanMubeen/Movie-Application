// Import necessary packages from Flutter and external libraries
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cine_noir/components/heading_for_movie_lister.dart';
import 'package:cine_noir/components/movie_Item_widget%20.dart';
import 'package:cine_noir/Models/movie_model.dart';

// Define a stateless widget for a vertical movie lister
class VerticalMovieLister extends StatelessWidget {
  // Declare variables to hold the list of movies and heading
  final Future<List<Movie>> movies;
  final String heading;

  // Constructor to initialize the variables
  const VerticalMovieLister(
      {super.key, required this.movies, required this.heading});

  // Build method to create the widget's UI
  @override
  Widget build(BuildContext context) {
    // Return a column widget with a list of movie items
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Align children to the start of the column
      children: [
        HeadingForMovieLister(
            heading: heading), // Display the heading for the movie lister
        FutureBuilder(
          future: movies, // Specify the future to wait for
          builder: (context, snapshot) {
            try {
              // Check the connection state of the future
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Show a loading indicator while waiting
              } else if (snapshot.hasError) {
                // Handle errors during the future execution
                return const Text('An unexpected error occurred.');
              } else if (snapshot.data == null) {
                return const Text(
                    'No data available'); // Display a message when no data is available
              } else {
                // Extract the list of movies from the snapshot data
                List<Movie> fetchedMovies = snapshot.data as List<Movie>;

                // Return a container with a staggered grid view of movie items
                return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    child: MasonryGridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 20.w,
                      itemCount: fetchedMovies.length,
                      itemBuilder: (context, index) {
                        // Return a movie item widget for each item in the list
                        return MovieItemWidget(
                          movie: fetchedMovies[index],
                          forVerticalMovieList: true,
                        );
                      },
                    ));
              }
            } catch (e) {
              // Handle any unexpected errors
              return const Text('An unexpected error occurred.');
            }
          },
        ),
      ],
    );
  }
}
