class MoviesModel {
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final String releaseDate;

  MoviesModel({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
  });

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      id: json['id'],
      title: json['title'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      voteAverage: json['vote_average'].toDouble(),
      releaseDate: json['release_date'],
    );
  }

  @override
  String toString() {
    return 'Movie{id: $id, title: $title, originalTitle: $originalTitle, overview: $overview, posterPath: $posterPath, backdropPath: $backdropPath, voteAverage: $voteAverage, releaseDate: $releaseDate}';
  }
}

class MoviesResponse {
  final int page;
  final int totalPages;
  final int totalResults;
  final List<MoviesModel> movies;

  MoviesResponse({
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required this.movies,
  });

  factory MoviesResponse.fromJson(Map<String, dynamic> json) {
    final movies = (json['results'] as List)
        .map((movieJson) => MoviesModel.fromJson(movieJson))
        .toList();
    return MoviesResponse(
      page: json['page'],
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
      movies: movies,
    );
  }

  @override
  String toString() {
    return 'MoviesResponse{page: $page, totalPages: $totalPages, totalResults: $totalResults, movies: $movies}';
  }
}
