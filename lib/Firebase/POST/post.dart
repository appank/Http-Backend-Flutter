import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FirebasePOST extends StatelessWidget {
  FirebasePOST({super.key});
  final TextEditingController key1Controller = TextEditingController();
  final TextEditingController key2Controller = TextEditingController();
  Future<void> postData() async {
    final String firebaseUrl =
        'https://tes-api-flutter-default-rtdb.firebaseio.com/data.json';

    final Map<String, dynamic> postData = {
      'key1': key1Controller.text,
      'key2': key2Controller.text,
    };

    final response = await http.post(
      Uri.parse(firebaseUrl),
      body: json.encode(postData),
    );

    if (response.statusCode == 200) {
      // Data berhasil dipost
      print('Data berhasil dipost');
    } else {
      // Gagal memposting data
      print('Gagal memposting data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Key 1'),
              controller: key1Controller,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Key 2'),
              controller: key2Controller,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                postData();
              },
              child: Text('Post Data'),
            ),
          ],
        ),
      ),
    );
  }
}
