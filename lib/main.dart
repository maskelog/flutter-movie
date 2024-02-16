import 'package:flutter/material.dart';
import 'package:flutter_movie/screens/home_screens.dart';
import 'package:flutter_movie/services/api_service.dart';

void main() {
  ApiService().getMovies();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
