import 'package:firebase/Tips&Tricks/Abduction.dart';
import 'package:firebase/Tips&Tricks/carsnowfall.dart';
import 'package:firebase/Tips&Tricks/deserttips.dart';
import 'package:firebase/Tips&Tricks/landscape.dart';
import 'package:firebase/Tips&Tricks/wildlife.dart';
import 'package:flutter/material.dart';

import 'Wilderness.dart';

class SurvivalTips extends StatefulWidget {
  SurvivalTips({Key? key}) : super(key: key);

  @override
  State<SurvivalTips> createState() => _SurvivalTipsState();
}

class _SurvivalTipsState extends State<SurvivalTips> {
  @override
  Widget build(BuildContext context) {
    List<String> litems = ["1", "2", "Third", "4"];
    return DefaultTabController(
      length: 7,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Survival App'),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.emergency_outlined,
                  ),
                  text: 'Essential Desert Survival Tips',
                ),
                Tab(
                  icon: Icon(
                    Icons.emergency_sharp,
                  ),
                  text: 'Wild Life',
                ),
                Tab(
                  icon: Icon(
                    Icons.contacts,
                  ),
                  text: 'landslide',
                ),
                Tab(
                  icon: Icon(
                    Icons.emergency_outlined,
                  ),
                  text: 'AbductionOrHostage',
                ),
                Tab(
                  icon: Icon(
                    Icons.snowboarding,
                  ),
                  text: 'CarInSnowStorm',
                ),
                Tab(
                  icon: Icon(
                    Icons.emergency_outlined,
                  ),
                  text: 'Wilderness',
                ),
                Tab(
                  icon: Icon(
                    Icons.fire_extinguisher,
                  ),
                  text: 'WildFire',
                ),
              ],
            ),
          ),
          body: TabBarView(
      children: <Widget>[
        DesertTips(),
        WildLife(),
        LandSlide(),
        AbductionOrHostage(),
        CarInSnowStorm(),
        Wilderness(),
        WildLife()
        // SearchBar
      ],
        )
      ));
  }
}
