import 'package:api_flutter/Firebase/AnimeListApp/home/home.dart';
import 'package:api_flutter/Firebase/GET/get.dart';
import 'package:api_flutter/Firebase/Home/home.dart';
import 'package:api_flutter/Web/web1/home/home.dart';
import 'package:api_flutter/Web/web2/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Firebase CRUD',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeAnimeList());
  }
}
