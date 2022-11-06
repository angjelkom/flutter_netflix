class Configuration {
  final ImageConfiguration images;
  final List<String> changeKeys;

  Configuration.fromJson(Map<String, dynamic> json)
      : images = ImageConfiguration.fromJson(json['images']),
        changeKeys = List.castFrom<dynamic, String>(json['change_keys']);
}

class ImageConfiguration {
  final String baseUrl;
  final String secureBaseUrl;
  final List<String> backdropSizes;
  final List<String> logoSizes;
  final List<String> posterSizes;
  final List<String> profileSizes;
  final List<String> stillSizes;

  ImageConfiguration.fromJson(Map<String, dynamic> json)
      : baseUrl = json['base_url'],
        secureBaseUrl = json['secure_base_url'],
        backdropSizes = List.castFrom<dynamic, String>(json['backdrop_sizes']),
        logoSizes = List.castFrom<dynamic, String>(json['logo_sizes']),
        posterSizes = List.castFrom<dynamic, String>(json['poster_sizes']),
        profileSizes = List.castFrom<dynamic, String>(json['profile_sizes']),
        stillSizes = List.castFrom<dynamic, String>(json['still_sizes']);
}
