// Importing the 'movie_model.dart' file which likely contains the Movie class or related model.
import 'package:cine_noir/Models/movie_model.dart';

// Importing the 'movie_service.dart' file which likely contains the MovieService class or related functions.
import 'package:cine_noir/Models/movie_service.dart';

// Defining a constant variable 'apiKey' with your API key for authentication with The Movie Database (TMDb) API.
const apiKey = '9292a137ea138e39af019b8c6fd5bb9c';

// Defining a constant variable 'baseUrl' with the base URL for fetching movie poster images from TMDb API.
const baseUrl = 'https://image.tmdb.org/t/p/w500';

// Fetching a list of top-rated movies using the MovieService class and the 'getMovies' method.
Future<List<Movie>> topRatedMovies = MovieService.getMovies(
    'https://api.themoviedb.org/3/movie/top_rated?api_key=');

// Fetching a list of movies that are currently trending today using the MovieService class and the 'getMovies' method.
Future<List<Movie>> trendingToday = MovieService.getMovies(
    'https://api.themoviedb.org/3/trending/movie/day?api_key=');

// Fetching a list of movies that are trending this week using the MovieService class and the 'getMovies' method.
Future<List<Movie>> trendingThisWeek = MovieService.getMovies(
    'https://api.themoviedb.org/3/trending/movie/week?api_key=');

// Fetching a list of more movies using the MovieService class and the 'getMovies' method, possibly with additional parameters.
Future<List<Movie>> moreMovies = MovieService.getMovies(
    'https://api.themoviedb.org/3/discover/movie?api_key=');
