class Movie {
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final String originalName;
  final String originalLanguage;
  final String type;
  final List<int> genreIds;
  final double popularity;
  final DateTime? releaseDate;
  final double voteAverage;
  final int voteCount;
  final List<String> originCountry;
  final String? backdropPath;
  final bool adult;
  final bool video;
  final int? runtime;
  final int? episodes;
  final int? seasons;
  final bool details;

  Movie.fromJson(Map<String, dynamic> json, {medialType, this.details = false})
      : id = json['id'],
        name = json['name'] ?? json['title'],
        overview = json['overview'],
        posterPath = json['poster_path'],
        originalName = json['original_name'] ?? json['original_title'],
        originalLanguage = json['original_language'],
        type = json['media_type'] ?? medialType,
        genreIds = List.castFrom<dynamic, int>(json['genre_ids'] ?? []),
        popularity = json['popularity'],
        releaseDate =
            DateTime.tryParse(json['first_air_date'] ?? json['release_date']),
        voteAverage = json['vote_average'].toDouble(),
        voteCount = json['vote_count'],
        originCountry =
            List.castFrom<dynamic, String>(json['origin_country'] ?? []),
        backdropPath = json['backdrop_path'],
        adult = json['adult'] ?? false,
        video = json['video'] ?? false,
        runtime = json['runtime'],
        episodes = json['number_of_episodes'],
        seasons = json['number_of_seasons'];

  String getRuntime() {
    if (type == 'movie') {
      var hours = runtime! / 60,
          justHours = hours.floor(),
          minutes = ((hours - hours.floor()) * 60).floor();
      return '${justHours > 0 ? '${justHours}h' : ''}${minutes > 0 ? '${justHours > 0 ? ' ' : ''}${minutes}m' : ''}';
    }

    return episodes! < 20 ? '$episodes Episodes' : '$seasons Seasons';
  }
}
