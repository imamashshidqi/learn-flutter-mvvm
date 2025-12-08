import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OmdbService {
  final String apiKey = dotenv.env['API_KEY']!;
  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<List<dynamic>> getMovies(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl?apiKey=$apiKey&s=$query'),
    );

    if (response == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['Response'] == "True") {
        return data['Search'];
      } else {
        return [];
      }
    } else {
      throw Exception('Gagal terkoneksi ke Server!');
    }
  }
}
