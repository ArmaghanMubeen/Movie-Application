// Define a class named MovieImage
class MovieImage {
  // Declare a final variable filePath of type String to store the file path
  final String filePath;

  // Constructor for MovieImage class, taking filePath as a required parameter
  MovieImage({required this.filePath});

  // Factory method to create a MovieImage object from JSON data
  factory MovieImage.fromJson(Map<String, dynamic> json) {
    // Return a new MovieImage instance with filePath initialized from 'file_path' in the JSON data
    return MovieImage(
      filePath: json['file_path'],
    );
  }
}
