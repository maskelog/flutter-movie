import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  final String popular = "popular";
  final String nowplaying = "now-playing";
  final String comingsoon = "coming-soon";

  void getMovies() async {
    final url = Uri.parse('$baseUrl/$popular');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final utf8EncodedBody = utf8.decode(response.bodyBytes);
      print(utf8EncodedBody);
      return;
    }

    throw Error();
  }
}
