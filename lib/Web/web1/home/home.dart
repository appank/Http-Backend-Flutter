import 'package:api_flutter/Web/web1/model/model.dart';
import 'package:api_flutter/Web/web1/model/repository.dart';
import 'package:flutter/material.dart';

class MyHomeWidget extends StatefulWidget {
  @override
  State<MyHomeWidget> createState() => _MyHomeWidgetState();
}

class _MyHomeWidgetState extends State<MyHomeWidget> {
  Map<String, dynamic>? responseData;
  List<Address> address = [];
  Repository repository = Repository();

  getData() async {
    address = await repository.getData();
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MockApi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                child: ClipRRect(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nama Kota : ' + address[index].NamaKota),
                      Text('Nama Negara : ' + address[index].NamaNegara),
                      Text('Kode Pos : ' + address[index].KodePos),
                      Text('Id : ' + address[index].id),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: address.length),
      ),
    );
  }
}
