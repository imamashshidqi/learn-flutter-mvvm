import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mvvm/models/movie_model.dart';

class MovieDetail {
  final String title;
  final String year;
  final String poster;
  final String plot;
  final String director;
  final String genre;

  MovieDetail({
    required this.title,
    required this.year,
    required this.poster,
    required this.plot,
    required this.director,
    required this.genre,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      title: json['Title'] ?? 'No Title',
      year: json['Year'] ?? 'N/A',
      poster: (json['Poster'] != null && json['Poster'] != 'N/A')
          ? json['Poster']
          : dotenv.env['DUMMY_POSTER_URL'],
      plot: json['Plot'] ?? 'Deskripsi tidak tersedia',
      director: json['Director'] ?? 'N/A',
      genre: json['Genre'] ?? 'N/A',
    );
  }
}
