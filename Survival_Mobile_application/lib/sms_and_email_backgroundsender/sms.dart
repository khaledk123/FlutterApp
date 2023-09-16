import 'dart:ffi';

import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class background_sms extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<background_sms> {
  savePref(String numbers) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('numbers', numbers);
    print(preferences.getString('numbers'));
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var numbers = preferences.getString('numbers');
  }

  _getPermission() async => await [
        Permission.sms,
      ].request();

  Future<bool> _isPermissionGranted() async =>
      await Permission.sms.status.isGranted;

  _sendMessage(String phoneNumber, String message, {int? simSlot}) async {
    var result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot: simSlot);
    if (result == SmsStatus.sent) {
      print("Sent");
    } else {
      print("Failed");
    }
  }

  Future<bool?> get _supportCustomSim async =>
      await BackgroundSms.isSupportCustomSim;

      @override
      void initState() {
        super.initState();
        getPref();
      }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Testing'),
      ),
      body: Container(
          child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('01027387629'),
            onTap: () {},
          ),
          ListTile(
            title: Text('01027387629'),
            onTap: () {},
          ),
          ListTile(
            title: Text('01027387629'),
            onTap: () {},
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.send),
          onPressed: () async {
            if (await _isPermissionGranted()) {
              if ((await _supportCustomSim)!)
                _sendMessage("01027387629", "Teating", simSlot: 1);
              else
                _getPermission();
            }
          }),
    )
    );
  }
}
