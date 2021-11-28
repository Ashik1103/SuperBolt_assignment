import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:assignment/detailsPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

Map mapResponse;
List listResponse;

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  Future apicall() async {
    http.Response response;
    response =
        await http.get(Uri.parse("https://randomuser.me/api/?results=50"));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse['results'];
        // debugger();
        print(listResponse[0]);
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Users"),
      ),
      body: ListView.builder(
        itemCount: listResponse == null ? 0 : listResponse.length,
        itemBuilder: (context, index) {
          return Container(
            height: 140,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(
                      listResponse: listResponse[index],
                    ),
                  ),
                );
              },
              child: Card(
                color: Colors.tealAccent,
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Image.network(
                      listResponse[index]['picture']['large'],
                      height: 100,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(height: 40),
                          Text(
                            listResponse[index]['name']['first'],
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            listResponse[index]['email'],
                            style: TextStyle(
                              fontSize: 16,
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
    );
  }
}
