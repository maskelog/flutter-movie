import 'dart:convert';
import 'package:flutter_movie/models/detail_model.dart';
import 'package:flutter_movie/models/popular_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String popular = "popular";
  static const String nowplaying = "now-playing";
  static const String comingsoon = "coming-soon";

  static Future<List<MoviesModel>> getMovies() async {
    return _fetchMoviesFromEndpoint(popular);
  }

  static Future<List<MoviesModel>> getNowPlayingMovies() async {
    return _fetchMoviesFromEndpoint(nowplaying);
  }

  static Future<List<MoviesModel>> getComingSoonMovies() async {
    return _fetchMoviesFromEndpoint(comingsoon);
  }

  static Future<MovieDetailModel> getMovieDetails(int movieId) async {
    final Uri url = Uri.parse('$baseUrl/movie?id=$movieId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return MovieDetailModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  // 공통 로직 처리를 위한 private 메서드
  static Future<List<MoviesModel>> _fetchMoviesFromEndpoint(
      String endpoint) async {
    final Uri url = Uri.parse('$baseUrl/$endpoint');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> parsedJson = json.decode(decodedBody);
      MoviesResponse moviesResponse = MoviesResponse.fromJson(parsedJson);

      return moviesResponse.movies;
    } else {
      throw Exception(
          'Failed to load movies from $endpoint with status code: ${response.statusCode}');
    }
  }
}
