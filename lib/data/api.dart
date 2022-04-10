import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:music_player/models/artist.dart';

class API {
  static Future<List<Artist>> searchArtist(String artist) async {
    final artistQuery = artist.replaceAll(' ', '+');
    final response = await http.get(Uri.parse(
        "https://itunes.apple.com/search?term=$artistQuery&media=music"));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> results = jsonResponse["results"];
      return results.map((e) => Artist.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load Artist");
    }
  }
}
