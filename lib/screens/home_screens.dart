import 'package:flutter/material.dart';
import 'package:flutter_movie/models/popular_model.dart';
import 'package:flutter_movie/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MoviesModel>> popularMovies = ApiService.getMovies();
  final Future<List<MoviesModel>> nowPlayingMovies =
      ApiService.getNowPlayingMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TOP Movies"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: Text(
                "Popular Movies",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FutureSection(moviesFuture: popularMovies),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: Text(
                "Now Playing",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FutureSection(moviesFuture: nowPlayingMovies),
          ],
        ),
      ),
    );
  }
}

// FutureBuilder와 ListView를 포함하는 재사용 가능한 위젯
class FutureSection extends StatelessWidget {
  final Future<List<MoviesModel>> moviesFuture;

  const FutureSection({Key? key, required this.moviesFuture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MoviesModel>>(
      future: moviesFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: 280,
            child: makeList(snapshot),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  ListView makeList(AsyncSnapshot<List<MoviesModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var movie = snapshot.data![index];
        String imageUrl = 'https://image.tmdb.org/t/p/w500${movie.posterPath}';
        return Column(
          children: [
            Container(
              width: 250,
              height: 200,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              movie.originalTitle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 20),
    );
  }
}
