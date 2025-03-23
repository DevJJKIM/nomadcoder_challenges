class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterUrl;
  final String backdropUrl;
  final double voteAverage;
  final String releaseDate;
  final int runtime;
  final List<String> genres;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterUrl,
    required this.backdropUrl,
    required this.voteAverage,
    required this.releaseDate,
    required this.runtime,
    required this.genres,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterUrl: 'https://image.tmdb.org/t/p/w500${json['poster_path'] ?? ''}',
      backdropUrl:
          'https://image.tmdb.org/t/p/original${json['backdrop_path'] ?? ''}',
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
      releaseDate: json['release_date'] ?? '',
      runtime: json['runtime'] ?? 0,
      genres:
          (json['genres'] as List<dynamic>?)
              ?.map((genre) => genre['name'] as String)
              .toList() ??
          [],
    );
  }
}
