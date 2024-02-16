import 'dart:convert';
import 'package:flutter_movie/models/popular_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String popular = "popular";
  static const String nowplaying = "now-playing";
  static const String comingsoon = "coming-soon";

  static Future<List<MoviesModel>> getMovies() async {
    final Uri url = Uri.parse('$baseUrl/$popular');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> parsedJson = json.decode(decodedBody);
      MoviesResponse moviesResponse = MoviesResponse.fromJson(parsedJson);

      return moviesResponse.movies;
    }
    throw Error();
  }
}
