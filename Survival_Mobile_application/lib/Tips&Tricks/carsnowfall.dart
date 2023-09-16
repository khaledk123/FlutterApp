import 'package:flutter/material.dart';
class CarInSnowStorm extends StatefulWidget {
  CarInSnowStorm({Key? key}) : super(key: key);

  @override
  State<CarInSnowStorm> createState() => _CarInSnowStormState();
}

class _CarInSnowStormState extends State<CarInSnowStorm> {
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
            title: Text('Tips For Surviving if you’re stranded in your car in a snowstorm:-\n-Don’t abandon your vehicle.\n-Make yourself visible to rescuers.\n-Clear the exhaust pipe regularly.\n-Use gas sparingly.\n-Keep warm and put on the clothes and blankets that are in your vehicle.'),
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



