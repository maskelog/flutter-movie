import 'dart:convert';
import 'dart:io';
import 'package:flutter_movie/models/popular_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  final String popular = "popular";

  Future<List<MoviesModel>> getMovies() async {
    final Uri url = Uri.parse('$baseUrl/$popular');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> parsedJson = json.decode(decodedBody);
      final List<MoviesModel> movies =
          MoviesResponse.fromJson(parsedJson).movies;

      for (var movie in movies) {
        print(movie.toString());
      }

      return movies;
    } else {
      print('Failed to load movies, Status code: ${response.statusCode}');
      throw HttpException(
          'Failed to load movies, Status code: ${response.statusCode}');
    }
  }
}
