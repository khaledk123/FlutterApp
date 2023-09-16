import 'dart:async';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:background_sms/background_sms.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


class sendMailFromLocalHost extends StatefulWidget {
  sendMailFromLocalHost({Key? key, required this.title}) : super(key: key);
 final String title;
  @override
  State<sendMailFromLocalHost> createState() => _sendMailFromLocalHostState();
}

class _sendMailFromLocalHostState extends State<sendMailFromLocalHost> {


var _latitude = "";
  var _longitude = "";
  var _altitude = "";
  var _speed = "";
  var _address = "";

  Future _updatePosition(String altitude) async {
    Position pos = await _determinePosition();
    List pm = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    setState(() {
      _latitude = pos.latitude.toString();
      _longitude = pos.longitude.toString();
      _altitude = pos.altitude.toString();
      _speed = pos.speed.toString();
      _address = pm[0].toString();
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
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
  Future sendEmail() async {
    String username = 'khaledkandli55@gmail.com';
    String password = 'bqipsjwadnxpetem';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'xxxx')
      ..recipients.add(
        'khaledkandli55@gmail.com',
      )
      ..ccRecipients.addAll(['khaledkandli55@gmail.com'])
      // ..bccRecipients.add(Address('xxxxxxx'))
      ..subject = 'I Need Help \n${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>My cureent location lat is $_latitude long is $_longitude alti is $_altitude </h1>\n<p></p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (erorr) {
      print('Message not sent.');
      for (var p in erorr.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('email',),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      body: Center(
        
        
        // child: ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //     padding: EdgeInsets.all(20),
        //     textStyle: TextStyle(fontSize: 24),
        //   ),
        //   child: Text('sendmail'),
        //   onPressed: sendEmail,
        //   ),
        // )
        child: IconButton(
            icon: Icon(Icons.circle_rounded),
            splashColor: Colors.red,
            color: Colors.red,
            iconSize: 250,
             onPressed: ()async  {
            //   if (await _isPermissionGranted()) {
            //     if ((await _supportCustomSim)!)
            //       _sendMessage("xxxxx", "Teating", simSlot: 1);
            //     else
            //       _sendMessage("xxxx", "Testing");
            //   } else
            //     _getPermission();
              sendEmail();
              showToast;
            }),
      ),
    );
  }

  showToast(String msg, {required int duration, required int gravity}) {
    Toast.show(msg, textStyle: context, duration: duration, gravity: gravity);
  }
}
