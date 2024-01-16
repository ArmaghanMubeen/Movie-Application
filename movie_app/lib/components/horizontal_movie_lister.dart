import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cine_noir/components/heading_for_movie_lister.dart';
import 'package:cine_noir/components/movie_Item_widget%20.dart';
import 'package:cine_noir/Models/movie_model.dart';

// Define a Flutter widget for a horizontal movie list.
class HorizontalMovieLister extends StatelessWidget {
  // Declare a Future that resolves to a list of Movie objects.
  final Future<List<Movie>> movies;

  // Declare a heading string for the movie list.
  final String heading;

  // Constructor for the HorizontalMovieLister widget.
  const HorizontalMovieLister(
      {super.key, required this.movies, required this.heading});

  // Override the build method to create the widget's UI.
  @override
  Widget build(BuildContext context) {
    // Return a column containing the movie list heading and a FutureBuilder.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display the heading for the movie list.
        HeadingForMovieLister(heading: heading),

        // Use a FutureBuilder to asynchronously build the widget based on the future.
        FutureBuilder(
          future: movies,
          builder: (context, snapshot) {
            try {
              // Check the connection state of the asynchronous operation.
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading indicator while waiting for data.
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Handle errors by displaying an error message.
                return const Text('An unexpected error occurred.');
              } else if (snapshot.data == null) {
                // Display a message when no data is available.
                return const Text('No data available');
              } else {
                // Extract the list of Movie objects from the snapshot data.
                List<Movie> fetchedMovies = snapshot.data as List<Movie>;

                // Display a horizontal ListView of MovieItemWidgets.
                return SizedBox(
                  height: 210.w,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: fetchedMovies.length,
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      itemBuilder: (BuildContext context, int index) {
                        // Display individual MovieItemWidgets for each movie.
                        return MovieItemWidget(
                          movie: fetchedMovies[index],
                          forVerticalMovieList: false,
                        );
                      }),
                );
              }
            } catch (e) {
              // Handle any unexpected errors with a generic error message.
              return const Text('An unexpected error occurred.');
            }
          },
        ),
      ],
    );
  }
}
