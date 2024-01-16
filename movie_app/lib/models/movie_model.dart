// Importing the constants file that contains the baseUrl for image URLs
import 'package:cine_noir/Utils/constants.dart';

// Defining a Movie class to represent movie details
class Movie {
  // Declaring instance variables for movie details
  final int id;
  final String title;
  final String releaseDate;
  final String overview;
  final String posterPath;
  final String bannerurl;
  final String language;
  final double vote;
  final int voteCount;
  bool isFavorite;

  // Constructor for the Movie class
  Movie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.overview,
    required this.posterPath,
    required this.bannerurl,
    required this.vote,
    required this.voteCount,
    required this.language,
    this.isFavorite = false,
  });

  // Factory method to create a Movie object from JSON data
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['original_title'],
      releaseDate: json['release_date'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      bannerurl: json['backdrop_path'],
      // Converting vote_average to a double value if it's an integer
      vote: json['vote_average'] is int
          ? (json['vote_average'] as int).toDouble()
          : json['vote_average'],
      voteCount: json['vote_count'],
      language: json['original_language'],
    );
  }

  // Method to get the complete poster URL for a movie
  String getPosterUrl() {
    return '$baseUrl$posterPath';
  }

  // Method to get the complete banner URL for a movie
  String getBannerUrl() {
    return '$baseUrl$bannerurl';
  }
}
