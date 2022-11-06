class TMDBImage {
  final int width;
  final int height;
  final String filePath;
  final double aspectRatio;
  final String? iso;

  TMDBImage.fromJson(Map<String, dynamic> json)
      : width = json['width'],
        height = json['height'],
        filePath = json['file_path'],
        aspectRatio = json['aspect_ratio'],
        iso = json['iso_639_1'];
}

class TMDBImages {
  final int id;
  final List<TMDBImage> posters;
  final List<TMDBImage> backdrops;
  final List<TMDBImage> logos;

  TMDBImages.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        posters =
            List.castFrom<dynamic, Map<String, dynamic>>(json['posters'] ?? [])
                .map((e) => TMDBImage.fromJson(e))
                .toList(),
        backdrops = List.castFrom<dynamic, Map<String, dynamic>>(
                json['backdrops'] ?? [])
            .map((e) => TMDBImage.fromJson(e))
            .toList(),
        logos =
            List.castFrom<dynamic, Map<String, dynamic>>(json['logos'] ?? [])
                .map((e) => TMDBImage.fromJson(e))
                .where((image) =>
                    image.iso == 'en' && !image.filePath.endsWith('.svg'))
                .toList();
}
