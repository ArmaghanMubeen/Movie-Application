// ignore_for_file: use_build_context_synchronously
// This line ignores warnings related to using BuildContext synchronously

import 'dart:convert';
// Importing the dart:convert library for JSON encoding and decoding

import 'package:cached_network_image/cached_network_image.dart';
// Importing the CachedNetworkImage widget for efficient loading and caching of network images

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// Importing Flutter framework and packages for UI development and screen utilities

import 'package:like_button/like_button.dart';
// Importing the LikeButton widget for adding a like/favorite button

import 'package:cine_noir/components/custom_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:cine_noir/components/heading_for_movie_detail_screen.dart';
import 'package:cine_noir/components/widget_for_displaying_movie_properties_in_movie_detail_screen.dart';
import 'package:cine_noir/functions/show_error_message.dart';
import 'package:cine_noir/models/movie_highlights.dart';
import 'package:cine_noir/Utils/colors.dart';
import 'package:cine_noir/Utils/constants.dart';
// Importing custom components, functions, and constants

import 'package:shared_preferences/shared_preferences.dart';
// Importing shared_preferences for persisting simple data locally

class MovieDetailsScreen extends StatefulWidget {
  // Class for the Movie Details screen, extending StatefulWidget
  // It receives information about a movie as parameters

  final int id;
  final String name;
  final String overview;
  final String bannerurl;
  final String posterurl;
  final double voteAverage;
  final int voteCount;
  final String releaseDate;
  final String language;

  // Constructor for initializing movie details
  const MovieDetailsScreen({
    Key? key,
    required this.name,
    required this.overview,
    required this.bannerurl,
    required this.posterurl,
    required this.voteAverage,
    required this.releaseDate,
    required this.voteCount,
    required this.language,
    required this.id,
  }) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
  // Create state for the MovieDetailsScreen
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  // State class for the MovieDetailsScreen

  List<String> filePaths = [];
  bool isFavorite = false;

  @override
  void initState() {
    // Initialization method called when the state is created
    super.initState();
    fetchData();
    // Fetch data about movie images

    // Load favorite status from SharedPreferences
    _loadFavoriteStatus();
  }

  void _loadFavoriteStatus() async {
    // Method to load favorite status from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = prefs.getBool('${widget.id}') ?? false;
      // Retrieve the favorite status or default to false if not found
    });
  }

  void _saveFavoriteStatus() async {
    // Method to save favorite status to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('${widget.id}', isFavorite);
    // Save favorite status with the movie ID as the key
  }

  Future<void> fetchData() async {
    // Asynchronous method to fetch movie images from API
    final String apiUrl =
        'https://api.themoviedb.org/3/movie/${widget.id}/images?api_key=$apiKey';
    // API endpoint for fetching movie images

    try {
      final response = await http.get(Uri.parse(apiUrl));
      // Send HTTP GET request to the API

      if (response.statusCode == 200) {
        // Check if the response status code is successful
        final List<dynamic> data = json.decode(response.body)['backdrops'];
        // Extract image data from the API response

        List<String> paths = data
            .map((dynamic item) =>
                'https://image.tmdb.org/t/p/w500${MovieImage.fromJson(item).filePath}')
            .toList();
        // Create a list of image paths from the extracted data

        setState(() {
          filePaths = paths;
          // Update the state with the list of image paths
        });
      } else {
        // Handle HTTP errors
        showErrorDialog(context, 'Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      // Handle other errors
      showErrorDialog(context, 'Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build method for constructing the UI of the MovieDetailsScreen
    return Scaffold(
      backgroundColor: black,
      // Set the background color of the screen

      body: ListView(children: [
        // Display information in a ListView
        SizedBox(
            height: 370.w,
            child: Stack(children: [
              // Stack widget to overlay widgets
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: CachedNetworkImage(
                  width: double.infinity,
                  imageUrl: widget.bannerurl,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
              // Display the banner image using CachedNetworkImage

              Positioned(
                  top: 160.w,
                  left: 15.w,
                  child: SizedBox(
                    height: 200.w,
                    width: 130.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      // Set the radius for the poster image
                      child: CachedNetworkImage(
                        imageUrl: widget.posterurl,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
              // Display the poster image with a rounded border

              Positioned(
                top: 15.w,
                right: 10.w,
                left: 10.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: CircleAvatar(
                        radius: 20.w,
                        backgroundColor: Colors.black.withOpacity(0.4),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: white,
                            size: 20.w,
                          ),
                        ),
                      ),
                    ),
                    // Display a back button to navigate back

                    CircleAvatar(
                      radius: 20.w,
                      backgroundColor: Colors.black.withOpacity(0.4),
                      child: LikeButton(
                        onTap: (isLiked) async {
                          isFavorite = !isFavorite;
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          // Save favorite status locally
                          isFavorite
                              ? _saveFavoriteStatus()
                              : prefs.remove('${widget.id}');

                          return !isLiked;
                        },
                        circleColor: const CircleColor(start: red, end: red),
                        bubblesColor: const BubblesColor(
                          dotPrimaryColor: red,
                          dotSecondaryColor: red,
                          dotThirdColor: red,
                          dotLastColor: red,
                        ),
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            isFavorite
                                ? CupertinoIcons.suit_heart_fill
                                : CupertinoIcons.suit_heart,
                            color: isFavorite ? red : white,
                            size: 20.w,
                          );
                        },
                      ),
                    ),
                    // Display a like button to mark as favorite
                  ],
                ),
              ),
              // Position the back button and like button

              Positioned(
                top: 225.w,
                left: 165.w,
                child: SizedBox(
                  width: 175.w,
                  child: CustomText(
                    text: widget.name,
                    fontSize: 19.sp,
                    color: white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Display the movie name with a custom text widget
            ])),
        // Display the banner image, poster image, back button, like button, and movie name

        SizedBox(height: 45.w),
        // Add vertical spacing

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Display movie properties using a custom widget
            WidgetForDisplayingMoviePropertiesInMovieDetailScreen(
                upperText: widget.voteAverage.toStringAsFixed(1),
                lowerText: '${widget.voteCount.toString()} votes',
                iconData: Icons.star,
                iconColor: Colors.yellow.shade800),
            WidgetForDisplayingMoviePropertiesInMovieDetailScreen(
                upperText: widget.language,
                lowerText: 'Language',
                iconData: Icons.language_outlined,
                iconColor: grey.shade300),
            WidgetForDisplayingMoviePropertiesInMovieDetailScreen(
                upperText: widget.releaseDate,
                lowerText: 'Releasing date',
                iconData: Icons.calendar_month,
                iconColor: grey.shade300)
          ],
        ),
        // Display movie properties in a row

        SizedBox(
          height: 30.w,
        ),
        // Add vertical spacing

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Divider(
            color: grey.shade800,
          ),
        ),
        // Add a horizontal divider with a custom color

        SizedBox(
          height: 20.w,
        ),
        // Add vertical spacing

        const HeadingForMovieDetailScreen(
          heading: 'Overview',
        ),
        // Display a heading for the movie overview section

        Container(
            padding: EdgeInsets.all(10.w),
            child: CustomText(
              text: widget.overview,
              fontSize: 12.5.sp,
              color: grey.shade400,
            )),
        // Display the movie overview using a custom text widget

        SizedBox(
          height: 30.w,
        ),
        // Add vertical spacing

        const HeadingForMovieDetailScreen(
          heading: 'Highlights',
        ),
        // Display a heading for the movie highlights section

        SizedBox(
          height: 20.w,
        ),
        // Add vertical spacing

        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 1500),
            autoPlayInterval: const Duration(seconds: 3),
            enlargeCenterPage: true,
            aspectRatio: 2,
          ),
          items: filePaths.map((String filePath) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(
                    color: black,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.w),
                    child: CachedNetworkImage(
                      imageUrl: filePath,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        // Display movie highlights using a CarouselSlider
        // Images are fetched from the API and displayed in a carousel

        SizedBox(
          height: 50.w,
        ),
        // Add vertical spacing
      ]),
    );
  }
}
