import 'package:api_flutter/Firebase/AnimeListApp/home/animeDetail.dart';
import 'package:api_flutter/Firebase/AnimeListApp/models/classAnime.dart';
import 'package:api_flutter/Firebase/AnimeListApp/services/servicesAnime.dart';
import 'package:flutter/material.dart';

class HomeAnimeList extends StatefulWidget {
  const HomeAnimeList({super.key});

  @override
  State<HomeAnimeList> createState() => _HomeAnimeListState();
}

class _HomeAnimeListState extends State<HomeAnimeList> {
  List<Anime> users = [];
  bool _isloading = true;

  void fecthUser() async {
    _isloading = true;
    final result = await AnimeServiece.fetchUsers();
    users = result;
    setState(() {});
    _isloading = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fecthUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anime List'),
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnimeDetailPage(anime: user),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
                      child: Card(
                        child: Row(
                          children: [
                            Image.network(
                              user.image,
                              width: 100,
                              height: 150,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      user.title,
                                    ),
                                    subtitle: Text(
                                      user.description,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
