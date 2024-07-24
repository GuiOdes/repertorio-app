import 'dart:convert';

import '../commons/Constants.dart';
import '../models/MusicModel.dart';
import 'package:http/http.dart' as http;

class MusicService {
  Future<List<Music>> findAllMusics() async {
    final response = await http.get(Uri.parse("$apiUrl/file"));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
      return jsonList.map((jsonItem) => Music.fromJson(jsonItem)).toList();
    } else {
      throw Exception('Falha ao obter a lista de músicas.');
    }
  }
}