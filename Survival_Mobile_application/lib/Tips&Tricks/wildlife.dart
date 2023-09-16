// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
class WildLife extends StatefulWidget {
  WildLife({Key? key}) : super(key: key);

  @override
  State<WildLife> createState() => _WildLifeState();
}

class _WildLifeState extends State<WildLife> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('WildLife'),
            ),
            // ignore: avoid_unnecessary_containers
            body: Container(
                child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(
                      '-Stay Indoors When Possible.\n-Move Aside.\n-Move!\n-Brace Yourself.\n-Cover Yourself.\n-Stay Away From Water.\n-Listen to warnings on the Radio.\n-Know the Area.\n-Stay Awake.'),
                  onTap: () {},
                ),
              ],
            )),
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.send), onPressed: () {})));
  }
}
