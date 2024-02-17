class MovieDetailModel {
  final bool adult;
  final String backdropPath;
  final List<Map<String, dynamic>> genres;
  final String homepage;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final int runtime;
  final String status;
  final String tagline;
  final String title;
  final double voteAverage;
  final int voteCount;

  MovieDetailModel({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      genres: List<Map<String, dynamic>>.from(json['genres']),
      homepage: json['homepage'],
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      runtime: json['runtime'],
      status: json['status'],
      tagline: json['tagline'],
      title: json['title'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
    );
  }
}
