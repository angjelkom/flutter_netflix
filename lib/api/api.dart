import 'dart:convert';

import 'package:http/http.dart' as http;

class TMDB {
  final endpoint = 'https://api.themoviedb.org/3';

  // Get a free key at: https://www.themoviedb.org/documentation/api
  final apiKey = 'b8735916ebe69a988e7a757928558cf0';

  Future<List<Map<String, dynamic>>> getTrending(
      {type = 'all', time = 'week'}) async {
    var result = await http
        .get(Uri.parse('$endpoint/trending/$type/$time?api_key=$apiKey'));
    var body = jsonDecode(result.body);
    return List.castFrom<dynamic, Map<String, dynamic>>(body['results']);
  }

  Future<Map<String, dynamic>> getConfiguration() async {
    var result =
        await http.get(Uri.parse('$endpoint/configuration?api_key=$apiKey'));
    return jsonDecode(result.body);
  }

  Future<Map<String, dynamic>> getDetails(id, type) async {
    var result =
        await http.get(Uri.parse('$endpoint/$type/$id?api_key=$apiKey'));
    return jsonDecode(result.body);
  }

  Future<Map<String, dynamic>> getSeason(id, season) async {
    var result = await http
        .get(Uri.parse('$endpoint/tv/$id/season/$season?api_key=$apiKey'));
    return jsonDecode(result.body);
  }

  Future<List<Map<String, dynamic>>> discover(type) async {
    var result =
        await http.get(Uri.parse('$endpoint/discover/$type?api_key=$apiKey'));
    var body = jsonDecode(result.body);
    return List.castFrom<dynamic, Map<String, dynamic>>(body['results']);
  }

  Future<Map<String, dynamic>> getImages(id, type) async {
    var result =
        await http.get(Uri.parse('$endpoint/$type/$id/images?api_key=$apiKey'));
    return jsonDecode(result.body);
  }
}
