import 'package:flutter_mvvm/models/movie_model.dart';
import 'package:flutter_mvvm/data/services/omdb_service.dart';

class MovieRepository {
  final OmdbService _omdbService;

  MovieRepository({required OmdbService omdbService})
    : _omdbService = omdbService;

  Future<List<Movie>> fetchMovies(String query) async {
    try {
      final rawData = await _omdbService.getMovies(query);
      return rawData.map((json) => Movie.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
