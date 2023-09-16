import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';
class WildFire extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  WildFire({Key? key}) : super(key: key);

  @override
  State<WildFire> createState() => _WildFireState();
}

class _WildFireState extends State<WildFire> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('WildFire'),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
          child: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('-Evacuate Early.\n-Avoid Dust and Smoke.\n-Move!\n-Seek Out Cover.\n-Cover Yourself.\n-Steer Clear of Canyons.\n-Dodge Dry Leaves.\n-Have an Escape Plan.'),
            onTap: () {},
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.send),
          onPressed: (){}
          
    )
    
  
));
}
}