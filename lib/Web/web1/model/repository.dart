import 'dart:convert';
import 'package:api_flutter/Web/web1/model/model.dart';
import 'package:http/http.dart' as http;

class Repository {
  final _baseURL = 'https://65c365d039055e7482c0ca75.mockapi.io/address';
  Future getData() async {
    final response = await http.get(Uri.parse(_baseURL));
    if (response.statusCode == 200) {
      Iterable it = jsonDecode(response.body);
      List<Address> address = it.map((e) => Address.fromJson(e)).toList();
      return address;
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  }
}
