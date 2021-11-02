import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dog_api/data.dart';
//This file  retrieves and decodes the Json data
//recievd fron the API.

class API extends StatefulWidget {
  const API({Key? key}) : super(key: key);

  @override
  _APIState createState() => _APIState();
}

class _APIState extends State<API> {
  Future getimage() async {
    var response = await http.get(Uri.parse(api)); //Json data recieved

    if (response.statusCode == 200) {
      setState(() {
        mapres = jsonDecode(response.body); //Json data decoded

        dogimage = mapres['message']; //extracted the url to string
      });
    } else {
      Text(Error);
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
                child: dogimage == 'null'
                    ? Container(
                        child: Image.network(
                            loading)) //while the image is loading show loading screen
                    : Container(child: Image.network(dogimage))),
            new Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                child: Text("Fetch"),
                onPressed: () {
                  getimage();
                },
              ),
            )
          ],
        ));
  }
}
