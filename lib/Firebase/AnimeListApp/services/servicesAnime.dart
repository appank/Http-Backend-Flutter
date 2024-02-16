import 'dart:convert';
import 'package:api_flutter/Firebase/AnimeListApp/models/classAnime.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AnimeServiece {
  //https://reqres.in/api/users?page=2'
  static const String _baseURL =
      'https://tes-api-flutter-default-rtdb.firebaseio.com/Anime.json';
  static Future<List<Anime>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(_baseURL));
      final body = response.body;
      final result = jsonDecode(body);
      List<Anime> users = (result as List<dynamic>).map<Anime>((user) {
        return Anime.fromJson(user as Map<String, dynamic>);
      }).toList();
      return users;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
