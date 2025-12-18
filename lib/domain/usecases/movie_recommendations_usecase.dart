import 'package:flutter_mvvm/data/repositories/movie_repository.dart';
import 'package:flutter_mvvm/domain/models/movie_detail_result_model.dart';

class MovieRecommendationsUsecase {
  final MovieRepository repository;

  MovieRecommendationsUsecase({required this.repository});

  Future<MovieDetailResult> execute(String imdbID) async {
    final detail = await repository.getMovieDetail(imdbID);
    String firstGenre = "Movie";

    if (detail.genre != "N/A" && detail.genre.isNotEmpty) {
      firstGenre = detail.genre.split(",")[0].trim();
    }

    final searchResult = await repository.fetchMovies(firstGenre);

    final recommendations = searchResult.where((movie) {
      final isDifferentMovie = movie.imdbID != detail.imdbID;
      final hasPoster = movie.poster != "N/A" && movie.poster.isNotEmpty;
      return isDifferentMovie && hasPoster;
    }).toList();

    return MovieDetailResult(
      movieDetail: detail,
      movieRecommendations: recommendations,
    );
  }
}
