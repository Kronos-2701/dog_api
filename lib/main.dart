import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: API(),
    );
  }
}

late Map mapres;
late Map ures;
late String dogimage;

class API extends StatefulWidget {
  const API({Key? key}) : super(key: key);

  @override
  _APIState createState() => _APIState();
}

class _APIState extends State<API> {
  Future getimage() async {
    var response =
        await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));

    if (response.statusCode == 200) {
      setState(() {
        mapres = jsonDecode(response.body);

        dogimage = mapres['message'];
      });
    }
  }

  @override
  void initState() {
    getimage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dog API'),
        ),
        body: Column(
          children: [
            new Center(
                child: dogimage == null
                    ? Text("Loading Image")
                    : Container(child: Image.network(dogimage))),
            new ElevatedButton(
              child: Text("Fetch"),
              onPressed: () {
                getimage();
              },
            ),
            //new Text(dogimage)
          ],
        ));
  }
}
