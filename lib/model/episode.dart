class Episode {
  final int id;
  final String name;
  final String? overview;
  final int episodeNumber;
  final String? stillPath;
  final DateTime? airDate;

  Episode.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        overview = json['overview'],
        episodeNumber = json['episode_number'],
        stillPath = json['still_path'],
        airDate = DateTime.tryParse(json['air_date']);
}
