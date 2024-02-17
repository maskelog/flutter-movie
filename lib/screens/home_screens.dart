import 'package:flutter/material.dart';
import 'package:flutter_movie/models/popular_model.dart';
import 'package:flutter_movie/screens/Detail_screen.dart';
import 'package:flutter_movie/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MoviesModel>> popularMovies = ApiService.getMovies();
  final Future<List<MoviesModel>> nowPlayingMovies =
      ApiService.getNowPlayingMovies();
  final Future<List<MoviesModel>> comingSoonMovies =
      ApiService.getComingSoonMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
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
            FutureSection(moviesFuture: popularMovies, imageWidth: 300.0),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: Text(
                "Now in Cinemas",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FutureSection(moviesFuture: nowPlayingMovies, imageWidth: 200.0),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: Text(
                "Coming Soon",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FutureSection(moviesFuture: comingSoonMovies, imageWidth: 150.0),
          ],
        ),
      ),
    );
  }
}

// FutureBuilder와 ListView를 포함하는 재사용 가능한 위젯
class FutureSection extends StatelessWidget {
  final Future<List<MoviesModel>> moviesFuture;
  final double imageWidth;

  const FutureSection(
      {Key? key, required this.moviesFuture, this.imageWidth = 250.0})
      : super(key: key);

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
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailScreen(movieId: movie.id),
              ),
            );
          },
          child: Column(
            children: [
              Container(
                width: imageWidth,
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
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 20),
    );
  }
}
