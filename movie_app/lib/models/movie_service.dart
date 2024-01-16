import 'dart:convert'; // Importing the dart:convert library for JSON encoding and decoding
import 'package:flutter/foundation.dart'; // Importing Flutter's foundation library for debugging
import 'package:http/http.dart'
    as http; // Importing the http package for making HTTP requests
import 'package:cine_noir/Models/movie_model.dart'; // Importing the Movie model class
import 'package:cine_noir/Utils/constants.dart'; // Importing constants, like the API key

class MovieServiceException implements Exception {
  final String message;

  MovieServiceException(this.message);

  @override
  String toString() =>
      'MovieServiceException: $message'; // Custom exception for movie service errors
}

class MovieService {
  static Future<List<Movie>> getMovies(String url) async {
    try {
      final response = await http.get(
        Uri.parse(url +
            apiKey), // Making an HTTP GET request to the provided URL with the API key
      );

      if (response.statusCode == 200) {
        final List<dynamic>? data = json.decode(response.body)[
            'results']; // Decoding JSON response and extracting 'results'

        if (data != null) {
          List<Movie> movies = List<Movie>.from(data.map((json) =>
              Movie.fromJson(
                  json))); // Converting JSON data to a list of Movie objects

          return movies; // Returning the list of movies
        } else {
          _handleError(
              'Received null data from the API'); // Handling the case where data is null
        }
      } else {
        _handleError(
            'Failed to load movies. Status Code: ${response.statusCode}'); // Handling non-200 HTTP status code
      }
    } catch (e) {
      _handleError(
          'Error fetching movies: $e'); // Handling general errors during the HTTP request
    }

    // Add a return statement here to satisfy the return type
    return []; // You can return an empty list or handle it based on your logic
  }

  static void _handleError(String errorMessage) {
    if (kDebugMode) {
      print(
          'Error: $errorMessage'); // Printing error message to console in debug mode
    }
    throw MovieServiceException(
        errorMessage); // Throwing a custom exception for error handling
  }
}
