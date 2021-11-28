import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatefulWidget {
  final Map listResponse;
  const DetailsPage({Key key, @required this.listResponse}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState(this.listResponse);
}

class _DetailsPageState extends State<DetailsPage> {
  final Map listResponse;

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print("could not launch" + command);
    }
  }

  _DetailsPageState(this.listResponse);
  @override
  Widget build(BuildContext context) {
    // debugger();
    print(listResponse);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            height: 580,
            width: 450,
            color: Color(0xffD3D3D3),
            child: Column(
              children: [
                SizedBox(height: 30),
                Image.network(listResponse['picture']['large']),
                SizedBox(
                  height: 30,
                ),
                Row(children: [
                  SizedBox(width: 10),
                  Text(
                    "Name :   ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    listResponse['name']['title'] +
                        '.' +
                        listResponse['name']['first'] +
                        ' ' +
                        listResponse['name']['last'],
                    style: TextStyle(fontSize: 20),
                  )
                ]),
                SizedBox(height: 60),
                GestureDetector(
                  onTap: () {
                    customLaunch('mailto:your@gmail.com');
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        "Email :   ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Flexible(
                        child: Text(
                          listResponse['email'],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      "Address :   ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Flexible(
                      child: Text(
                        listResponse['location']['city'] +
                            ',' +
                            listResponse['location']['state'] +
                            ',' +
                            listResponse['location']['country'],
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60),
                Row(children: [
                  SizedBox(width: 10),
                  Text(
                    "DOB :   ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    listResponse['dob']['date'].substring(0, 10),
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20)
                ]),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    customLaunch('tel:${listResponse['phone']}');
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        "Phone Number :   ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        listResponse['phone'],
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
