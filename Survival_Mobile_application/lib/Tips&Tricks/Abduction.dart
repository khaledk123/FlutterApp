// ignore: file_names
import 'package:flutter/material.dart';

class AbductionOrHostage extends StatefulWidget {
  const AbductionOrHostage({Key? key}) : super(key: key);

  @override
  State<AbductionOrHostage> createState() => _AbductionOrHostageState();
}

class _AbductionOrHostageState extends State<AbductionOrHostage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Abduction Or Hostage'),
            ),
            // ignore: avoid_unnecessary_containers
            body: Container(
                child: ListView(
              children: <Widget>[
                ListTile(
                  // ignore: prefer_const_constructors
                  title: Text(
                      'Situation1: If there someone tries to abduct you\n-Run away from someone who tries to take you if you can.\n-Yell to draw attention to the situation.\n-Fight your attacker as hard as you can.\n-Look for objects in your environment to use as weapons.\n-Keep Your Clothes On.\n\n Situation 2: If you have already been kidnapped\n-Follow your captors instructions once you are in captivity.\n-Stay calm and focused on survival.\n-Try to connect with your kidnappers, but dont pretend to support them\n-Observe as much of your environment as you can.\n-Find a way to communicate if there are other captives.\n-Prepare yourself to be held for a long time.\n-Wait to be rescued unless you are sure you can escape safely.'),
                  onTap: () {},
                ),
              ],
            )),
            floatingActionButton: FloatingActionButton(
                // ignore: prefer_const_constructors
                child: Icon(Icons.send),
                onPressed: () {
                  Navigator.popAndPushNamed(context, './carsnowfall');
                })));
  }
}
