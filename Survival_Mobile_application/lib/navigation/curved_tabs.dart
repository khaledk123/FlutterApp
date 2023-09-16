import 'package:firebase/Tips&Tricks/Survival_tips.dart';
import 'package:firebase/compass/compass%20sample.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../Emergancy_Contacts/searchBar/search interface.dart';
import '../TRACKING/trackingmain.dart';
import '../chating_app/chat_screen.dart';
import '../googlemaps_screens/mainrun.dart';
import '../panicButton/panicbutton.dart';

// ignore: camel_case_types
class curvedNavBar extends StatefulWidget {
  static const String screenRoute = 'curvedNavBar';
  const curvedNavBar({Key? key}) : super(key: key);

  @override
  State<curvedNavBar> createState() => _curvedNavBarState();
}

// ignore: camel_case_types
class _curvedNavBarState extends State<curvedNavBar> {
  int _currentIndex = 0;
  void _changeItem(int value) {
    print(value);
    setState(() {
      _currentIndex = value;
    });
  }

  final List<Widget> _widgetOpions = <Widget>[
    PanicButton(title: '',),
    ChatScreen(),
    const EmergancyContactsSearchBar(),
    SurvivalTips(),
    const compassWidget(),
    const mapscreate(),
    GoogleMaps(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(''),backgroundColor: Colors.grey),
      body: _widgetOpions.elementAt(_currentIndex),
      bottomNavigationBar: CurvedNavigationBar(
        items: const [
          Icon(Icons.warning),
          Icon(Icons.chat),
          Icon(Icons.contacts),
          Icon(Icons.tips_and_updates),
          Icon(Icons.compass_calibration_rounded),
          Icon(Icons.track_changes),
          Icon(Icons.map_outlined),
        ],
        onTap: _changeItem,
        index: _currentIndex,
        color: Colors.grey,
        backgroundColor: Colors.blue,
        buttonBackgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 500),
        height: 50.0,
      ),
    );
  }
}
