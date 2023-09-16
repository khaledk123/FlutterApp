import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DesertTips extends StatefulWidget {
  DesertTips({Key? key}) : super(key: key);

  @override
  State<DesertTips> createState() => _DesertTipsState();
}

class _DesertTipsState extends State<DesertTips> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('DesertTips'),
      ),
      body: Container(
          child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('-Make a Fire.\n-Preserve Sweat not Water.\n-Don’t Drink the Cactus.\n-Stop Hunting for Food.\n-Stay Off The Ground. \n-Keep Your Clothes On.\n-Stay High.'),
            onTap: () {},
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.send),
          onPressed: (){}
          
    )
));
}
}