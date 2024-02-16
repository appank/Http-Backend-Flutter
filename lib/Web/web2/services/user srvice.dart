import 'dart:convert';

import 'package:api_flutter/Web/web2/models/user.dart';
import 'package:http/http.dart' as http;

class UserServiece {
  //https://reqres.in/api/users?page=2'
  static const String _baseURL = 'https://reqres.in/api';
  static Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('$_baseURL/users?page=2'));
      final body = response.body;
      final result = jsonDecode(body);
      List<User> users = List<User>.from(result['data'].map(
        (user) => User.fromJson(user),
      ));
      return users;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
