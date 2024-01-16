// ignore_for_file: file_names

// Import necessary packages and files
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cine_noir/components/custom_text.dart';
import 'package:cine_noir/Screens/movie_details_screen.dart';
import 'package:cine_noir/Models/movie_model.dart';
import 'package:cine_noir/Utils/colors.dart';

// Create a stateful widget for displaying a movie item
class MovieItemWidget extends StatefulWidget {
  final Movie movie;
  final bool forVerticalMovieList;

  // Constructor to initialize the widget with movie data and list type
  const MovieItemWidget(
      {super.key, required this.movie, required this.forVerticalMovieList});

  @override
  State<MovieItemWidget> createState() => _MovieItemWidgetState();
}

// State class for MovieItemWidget
class _MovieItemWidgetState extends State<MovieItemWidget> {
  @override
  Widget build(BuildContext context) {
    // InkWell for handling tap gestures
    return InkWell(
      onTap: () {
        // Navigate to MovieDetailsScreen on tap
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(
                      id: widget.movie.id,
                      name: widget.movie.title,
                      posterurl: widget.movie.getPosterUrl(),
                      overview: widget.movie.overview,
                      releaseDate: widget.movie.releaseDate,
                      bannerurl: widget.movie.getBannerUrl(),
                      voteAverage: widget.movie.vote,
                      voteCount: widget.movie.voteCount,
                      language: widget.movie.language,
                    )));
      },
      child: Container(
        // Container to hold movie item
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        width: 115.w,
        child: Column(
          children: [
            // Display movie poster using CachedNetworkImage
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(5.w), // Adjust the radius as needed
              child: CachedNetworkImage(
                imageUrl: widget.movie.getPosterUrl(),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.w,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Display IMDB label, star icon, and movie vote average
                    CustomText(
                      text: 'IMDB',
                      fontSize: widget.forVerticalMovieList ? 11.sp : 9.sp,
                      color: grey.shade300,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: widget.forVerticalMovieList ? 12.sp : 10.sp,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    CustomText(
                      text: widget.movie.vote.toStringAsFixed(1),
                      fontSize: widget.forVerticalMovieList ? 11.sp : 9.sp,
                      color: grey.shade300,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                ),
                SizedBox(
                  height: widget.forVerticalMovieList ? 0.w : 2.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Display vote count and release date
                    Expanded(
                      child: CustomText(
                        text: '${widget.movie.voteCount} votes',
                        fontSize: widget.forVerticalMovieList ? 10.sp : 8.sp,
                        color: grey.shade400,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    CustomText(
                      text: widget.movie.releaseDate,
                      fontSize: widget.forVerticalMovieList ? 12.sp : 9.sp,
                      color: grey.shade400,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
