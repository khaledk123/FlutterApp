import 'package:flutter/material.dart';

class LandSlide extends StatefulWidget {
  LandSlide({Key? key}) : super(key: key);

  @override
  State<LandSlide> createState() => _LandSlideState();
}

class _LandSlideState extends State<LandSlide> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('LandSlide'),
            ),
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
