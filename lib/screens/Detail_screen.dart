import 'package:flutter/material.dart';
import 'package:flutter_movie/models/detail_model.dart';
import 'package:flutter_movie/services/api_service.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<MovieDetailModel>(
        future: ApiService.getMovieDetails(movieId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final movie = snapshot.data!;
            return Stack(
              children: [
                // Full-screen background image
                Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                // Semi-transparent overlay
                Container(
                  color: Colors.black.withOpacity(0.5),
                ),
                // Content
                SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            BackButton(color: Colors.white),
                            Text(
                              "Back to list",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                movie.title,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              _buildRating(movie.voteAverage),
                              const SizedBox(height: 8),
                              Text(
                                '${movie.runtime} min | ${_getGenresString(movie.genres)}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'StoryLine',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                movie.overview,
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                      // This Spacer takes any available space, pushing the button and text to the bottom
                      const Spacer(),
                    ],
                  ),
                ),
                // Buy Ticket button positioned at the bottom center
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.25,
                  right: MediaQuery.of(context).size.width * 0.25,
                  bottom: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement ticket purchasing functionality
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.yellow, // Button text color
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.5,
                          50), // Button width
                    ),
                    child: const Text('Buy Ticket'),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("An error occurred"));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildRating(double voteAverage) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star, color: Colors.amber),
        const SizedBox(width: 4),
        Text(
          "${voteAverage.toStringAsFixed(1)} / 10",
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  String _getGenresString(List<dynamic> genres) {
    return genres.map((genre) => genre['name'].toString()).join(', ');
  }
}
