import 'package:flutter_mvvm/models/movie_detail_model.dart';
import 'package:flutter_mvvm/models/movie_model.dart';

class MovieDetailResult {
  final MovieDetail movieDetail;
  final List<Movie> movieRecommendations;

  MovieDetailResult({
    required this.movieDetail,
    required this.movieRecommendations,
  });
}
