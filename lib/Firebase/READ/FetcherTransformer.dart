import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataFetcherTransformer extends StatelessWidget {
  final String firebaseUrl =
      'https://tes-api-flutter-default-rtdb.firebaseio.com/data.json';

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(firebaseUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final data = snapshot.data!;
          final transformedData = transformData(data);
          return ListView.builder(
            itemCount: transformedData.length,
            itemBuilder: (context, index) {
              final item = transformedData[index];
              return ExpansionTile(
                title: Text('Item ${index + 1}: ${item['key1']}'),
                children: [
                  ListTile(
                    title: Text('Key1'),
                    subtitle: Text(item['key1'].toString()),
                  ),
                  ListTile(
                    title: Text('Key2'),
                    subtitle: Text(item['key2'].toString()),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }

  List<dynamic> transformData(Map<String, dynamic> data) {
    // You can add your data transformation logic here
    // For simplicity, just returning the values as a list
    return data.values.toList();
  }
}
