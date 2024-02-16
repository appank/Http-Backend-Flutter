import 'package:api_flutter/Web/web2/models/user.dart';
import 'package:api_flutter/Web/web2/services/user%20srvice.dart';
import 'package:flutter/material.dart';

class MyHomeweb2 extends StatefulWidget {
  const MyHomeweb2({super.key});

  @override
  State<MyHomeweb2> createState() => _MyHomeweb2State();
}

class _MyHomeweb2State extends State<MyHomeweb2> {
  List<User> users = [];
  bool _isloading = true;

  void fecthUser() async {
    _isloading = true;
    final result = await UserServiece.fetchUsers();
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
        title: Text('API'),
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
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar),
                      ),
                      title: Text(user.firstName + " " + user.lastName),
                      subtitle: Text(user.email),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
