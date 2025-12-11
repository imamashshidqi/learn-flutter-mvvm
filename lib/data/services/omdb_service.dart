import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OmdbService {
  final String apiKey = dotenv.env['API_KEY']!;
  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<List<dynamic>> getMovies(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl?apikey=$apiKey&s=$query'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['Response'] == "True") {
        return data['Search'];
      } else {
        return [];
      }
    } else {
      throw Exception('Gagal koneksi ke server');
    }
  }

  Future<Map<String, dynamic>> getMovieDetail(String imdbID) async {
    final response = await http.get(
      Uri.parse('$baseUrl?apikey=$apiKey&i=$imdbID'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal koneksi ke server');
    }
  }
}
