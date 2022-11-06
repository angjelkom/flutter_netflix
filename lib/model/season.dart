import 'package:flutter_netflix/model/episode.dart';

class Season {
  final int id;
  final String name;
  final int seasonNumber;
  final String? overview;
  final String? posterPath;
  final DateTime? airDate;
  final List<Episode> episodes;
  final List<String> starring;
  final List<String> creators;

  factory Season.fromJson(Map<String, dynamic> json) {
    List<String> starring = [];
    List<String> creators = [];
    List<Episode> episodes = [];

    for (final episode in json['episodes']) {
      for (final crew in episode['crew']) {
        if (crew['job'] == 'Writter' && creators.contains(crew['name'])) {
          creators.add(crew['name']);
        }
      }

      for (final actor in episode['guest_stars']) {
        if (starring.contains(actor['name'])) {
          creators.add(actor['name']);
        }
      }
      episodes.add(Episode.fromJson(episode));
    }

    return Season(
        json['id'],
        json['name'],
        json['season_number'],
        json['overview'],
        json['poster_path'],
        DateTime.tryParse(json['air_date']),
        episodes,
        starring,
        creators);
  }

  Season(this.id, this.name, this.seasonNumber, this.overview, this.posterPath,
      this.airDate, this.episodes, this.starring, this.creators);
}
