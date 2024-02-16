import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeFirebase extends StatefulWidget {
  HomeFirebase({super.key});

  @override
  State<HomeFirebase> createState() => _HomeFirebaseState();
}

class _HomeFirebaseState extends State<HomeFirebase> {
  Map<String, dynamic>? responseData;

  TextEditingController key1Controller = TextEditingController();

  TextEditingController key2Controller = TextEditingController();

  @override
  void dispose() {
    key1Controller.dispose();
    key2Controller.dispose();
    super.dispose();
  }

  //Tambah Data Metode Post
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

  //Dapatkan Data Metode Get
  Future<void> getData() async {
    final String firebaseUrl =
        'https://tes-api-flutter-default-rtdb.firebaseio.com/data.json';

    final response = await http.get(Uri.parse(firebaseUrl));

    if (response.statusCode == 200) {
      setState(() {
        responseData = json.decode(response.body);
      });
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  }

  //Delet Data
  Future<void> deleteData(String id) async {
    final String firebaseUrl =
        'https://tes-api-flutter-default-rtdb.firebaseio.com/data/$id.json';

    final response = await http.delete(Uri.parse(firebaseUrl));

    if (response.statusCode == 200) {
      print('Data deleted successfully');
      getData();
    } else {
      print('Failed to delete data: ${response.statusCode}');
    }
  }

  //Edit Data
  Future<void> editData(String id, String key1, String key2) async {
    final String firebaseUrl =
        'https://tes-api-flutter-default-rtdb.firebaseio.com/data/$id.json';

    final Map<String, dynamic> updatedData = {
      'key1': key1,
      'key2': key2,
    };

    final response = await http.patch(
      Uri.parse(firebaseUrl),
      body: json.encode(updatedData),
    );

    if (response.statusCode == 200) {
      print('Data edited successfully');
      getData();
    } else {
      print('Failed to edit data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Example - GET Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                getData();
              },
              child: Text('Get Data'),
            ),
            SizedBox(height: 20),
            Text('Data yang diambil:'),
            SizedBox(height: 10),
            Expanded(
              child: responseData != null
                  ? ListView(
                      children: responseData!.entries.map((entry) {
                        return ListTile(
                          title: Text('Key1: ${entry.value['key1']}'),
                          subtitle: Text('Key2: ${entry.value['key2']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Edit Data'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextField(
                                              controller: key1Controller,
                                              decoration: InputDecoration(
                                                labelText: 'New Key1',
                                              ),
                                            ),
                                            TextField(
                                              controller: key2Controller,
                                              decoration: InputDecoration(
                                                labelText: 'New Key2',
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              editData(
                                                entry.key,
                                                key1Controller.text,
                                                key2Controller.text,
                                              );
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Save'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  deleteData(entry.key);
                                },
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  : Center(
                      child: Text('No data available'),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Edit Data'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: key1Controller,
                      decoration: InputDecoration(
                        labelText: 'New Key1',
                      ),
                    ),
                    TextField(
                      controller: key2Controller,
                      decoration: InputDecoration(
                        labelText: 'New Key2',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      postData();
                      Navigator.of(context).pop();
                    },
                    child: Text('Save'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
