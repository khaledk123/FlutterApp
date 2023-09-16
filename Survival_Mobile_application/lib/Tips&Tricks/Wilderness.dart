import 'package:flutter/material.dart';

class Wilderness extends StatefulWidget {
  Wilderness({Key? key}) : super(key: key);

  @override
  State<Wilderness> createState() => _WildernessState();
}

class _WildernessState extends State<Wilderness> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Wilderness'),
            ),
            body: Container(
                child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(
                      '-Communication is Key.\n-Keep Your Head On.\n-Move!\n-Light that Fire.\n-Build a Shelter.\n-Stay Away From Water.\n-Have a First Aid Kit.\n-Know the Area.\n-Find a Water Source.\n-Make a Spear to Catch Food.'),
                  onTap: () {},
                ),
              ],
            )),
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.send), onPressed: () {})));
  }
}