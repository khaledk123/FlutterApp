import 'dart:async';
import 'dart:convert';
//import 'dart:js';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:background_sms/background_sms.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

class PanicButton extends StatefulWidget {
  PanicButton({Key? key, required this.title}) : super(key: key);
  late String title;
  late final String numbers;
  @override
  State<PanicButton> createState() => _sendMailFromLocalHostState();
}

class _sendMailFromLocalHostState extends State<PanicButton> {
  _getPermission() async => await [
        Permission.sms,
      ].request();
  late List<dynamic> numbers;
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

  var _latitude = "";
  var _longitude = "";
  var _altitude = "";
  var _speed = "";
  var _address = "";
  late SharedPreferences sharedPreference;

  @override
  void initState() {
    _updatePosition(_altitude);
    super.initState();
    //numbers();
    //numbers();

    //code for add my location and enable button
    //_requestPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
    initialize();

    //
  }

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
      ..from = Address(username, 'user name')
      ..recipients.add(
        'khaledkandli55@gmail.com',
      )
      ..ccRecipients.addAll(['khaledkandli55@gmail.com'])
      // ..bccRecipients.add(Address('xxxxxxx'))
      ..subject = 'I Need Help \n${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html =
          "<h1>My cureent location lat is $_latitude long is $_longitude my speed is $_speed location is $_address</h1>\n<p></p>";

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

  //code for add my location and enable button
  final loc.Location location = loc.Location();

  StreamSubscription<loc.LocationData>? _locationSubscription;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(61, 228, 228, 228),
        appBar: AppBar(
          title: Text('Panic Button'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: controller, //for better keyboard// change later
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //set state
                  //numbers = value;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  numbers.add(controller.text);
                  print(jsonEncode(numbers));
                  sharedPreference.setString("contacts", jsonEncode(numbers));
                  print("saved");
                },
                child: const Text("Add number to your Emergency Contacts"),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (c) {
                        return Dialog(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Emergency Contacts",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 300,
                                  child: ListView(
                                    children: numbers
                                        .map((e) => Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.call,
                                                  size: 19,
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  e.toString(),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ],
                                            )))
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: const Text("show your Emergency Contacts"),
              ),
              Center(
                child: IconButton(
                  icon: Icon(Icons.circle_rounded),
                  splashColor: Colors.red,
                  color: Colors.red,
                  iconSize: 250,
                  onPressed: () async {
                    if (await _isPermissionGranted()) {
                      if ((await _supportCustomSim)!) {
                        for (var i in numbers) {
                          _sendMessage(i,
                              "I need help my location is $_latitude $_longitude\n check your Email ",
                              simSlot: 1);
                        }
                      } else
                        _sendMessage(numbers.first, "Testing");
                    } else
                      _getPermission();

                    sendEmail();
                    // showToast;
                    // _getLocation();
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.open_in_new),
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('warning\nHow to use'),
                        content: Text(
                            'Panic Button is an emergency button that can only be used in stress Situations where you feel in danger or someone is about to attack you once you press this button it will automatically get your current location and sends it to the contacts and emails of your choosing'),
                        actions: [
                          TextButton(
                              child: Text('Close'),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                          TextButton(
                            child: Text(
                                'I have read and agreed to all the terms and condations'),
                            onPressed: () {
                              Navigator.pop(context, './PanicButton');
                            },
                          )
                        ],
                      ));
            }
            // floatingActionButton: FloatingActionButton(
            //     child: Icon(Icons.open_in_new),
            //     onPressed: () {
            //   showDialog(
            //       context: context,
            //       builder: (context) => AlertDialog(
            //             title: Text('warning\nHow to use'),
            //             content: Text(
            //                 'Panic Button is an emergency button that can only be used in stress Situations where you feel in danger or someone is about to attack you once you press this button it will automatically get your current location and sends it to the contacts and emails of your choosing'),
            //             actions: [
            //               TextButton(
            //                   child: Text('Close'),
            //                   onPressed: () {
            //                     Navigator.pop(context);
            //                   }),
            //               TextButton(
            //                 child: Text(
            //                     'I have read and agreed to all the terms and condations'),
            //                 onPressed: () {
            //                   Navigator.pop(context);
            //                 },
            //               )
            //             ],
            //           ));
            // }),

            ));
  }

  initialize() async {
    sharedPreference = await SharedPreferences.getInstance();
    String? saved = sharedPreference.getString("contacts");
    if (saved != null) {
      numbers = jsonDecode(saved);
      print(numbers);
    } else
      numbers = [];
  }
}
  // showToast(String msg, {required int duration, required int gravity}) {
  //   Toast.show(msg, textStyle: context, duration: duration, gravity: gravity);
  // }









// import 'dart:async';
// import 'package:toast/toast.dart';
// import 'package:flutter/material.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';
// import 'package:background_sms/background_sms.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// //import 'package:google_map_live/mymap.dart';
// import 'package:location/location.dart' as loc;
// import 'package:permission_handler/permission_handler.dart';

// class PanicButton extends StatefulWidget {
//   PanicButton({Key? key, required this.title}) : super(key: key);
//   late String title;
//   late final String numbers;
//   @override
//   State<PanicButton> createState() => _sendMailFromLocalHostState();
// }

// class _sendMailFromLocalHostState extends State<PanicButton> {
//   _getPermission() async => await [
//         Permission.sms,
//       ].request();
//   var numbers;
//   Future<bool> _isPermissionGranted() async =>
//       await Permission.sms.status.isGranted;

//   _sendMessage(String phoneNumber, String message, {int? simSlot}) async {
//     var result = await BackgroundSms.sendMessage(
//         phoneNumber: phoneNumber, message: message, simSlot: simSlot);
//     if (result == SmsStatus.sent) {
//       print("Sent");
//     } else {
//       print("Failed");
//     }
//   }

//   Future<bool?> get _supportCustomSim async =>
//       await BackgroundSms.isSupportCustomSim;

//   var _latitude = "";
//   var _longitude = "";
//   var _altitude = "";
//   var _speed = "";
//   var _address = "";
//   @override
//   void initState() {
//     _updatePosition(_altitude);
//     super.initState();
//     //numbers();
//     //numbers();

//     //code for add my location and enable button
//     //_requestPermission();
//     location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
//     location.enableBackgroundMode(enable: true);
//     //
//   }

//   Future _updatePosition(String altitude) async {
//     Position pos = await _determinePosition();
//     List pm = await placemarkFromCoordinates(pos.latitude, pos.longitude);
//     setState(() {
//       _latitude = pos.latitude.toString();
//       _longitude = pos.longitude.toString();
//       _altitude = pos.altitude.toString();
//       _speed = pos.speed.toString();
//       _address = pm[0].toString();
//     });
//   }

//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition();
//   }

//   Future sendEmail() async {
//     String username = 'khaledkandli55@gmail.com';
//     String password = 'bqipsjwadnxpetem';

//     final smtpServer = gmail(username, password);
//     // Use the SmtpServer class to configure an SMTP server:
//     // final smtpServer = SmtpServer('smtp.domain.com');
//     // See the named arguments of SmtpServer for further configuration
//     // options.

//     // Create our message.
//     final message = Message()
//       ..from = Address(username, 'user name')
//       ..recipients.add(
//         'khaledkandli55@gmail.com',
//       )
//       ..ccRecipients.addAll(['khaledkandli55@gmail.com'])
//       // ..bccRecipients.add(Address('xxxxxxx'))
//       ..subject = 'I Need Help \n${DateTime.now()}'
//       ..text = 'This is the plain text.\nThis is line 2 of the text part.'
//       ..html =
//           "<h1>My cureent location lat is $_latitude long is $_longitude my speed is $_speed location is $_address</h1>\n<p></p>";

//     try {
//       final sendReport = await send(message, smtpServer);
//       print('Message sent: ' + sendReport.toString());
//     } on MailerException catch (erorr) {
//       print('Message not sent.');
//       for (var p in erorr.problems) {
//         print('Problem: ${p.code}: ${p.msg}');
//       }
//     }
//   }

//   //code for add my location and enable button
//   final loc.Location location = loc.Location();
//   StreamSubscription<loc.LocationData>? _locationSubscription;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color.fromARGB(97, 228, 228, 228),
//         appBar: AppBar(
//           title: Text('Panic Button'),
//           centerTitle: true,
//         ),
//         body: Column(
//           children: [
//             TextFormField(
//               keyboardType: TextInputType
//                   .emailAddress, //for better keyboard// change later
//               textAlign: TextAlign.center,
//               onChanged: (value) {
//                 //set state
//                 numbers = value;
//               },
//             ),
//             Center(
//               child: IconButton(
//                 icon: Icon(Icons.circle_rounded),
//                 splashColor: Colors.red,
//                 color: Colors.red,
//                 iconSize: 300,
//                 onPressed: () async {
//                   if (await _isPermissionGranted()) {
//                     if ((await _supportCustomSim)!) {
//                       _sendMessage(numbers,
//                           "I need help my location is $_latitude $_longitude\n check your Email ",
//                           simSlot: 1);
//                     } else
//                       _sendMessage(numbers, "Testing");
//                   } else
//                     _getPermission();

//                   sendEmail();
//                   showToast;
//                   // _getLocation();
//                 },
//               ),
//             ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//             child: Icon(Icons.open_in_new),
//             onPressed: () async {
//               final user = await numbers;
//             }
//             // floatingActionButton: FloatingActionButton(
//             //     child: Icon(Icons.open_in_new),
//             //     onPressed: () {
//             //       showDialog(
//             //           context: context,
//             //           builder: (context) => AlertDialog(
//             //                 title: Text('warning\nHow to use'),
//             //                 content: Text(
//             //                     'Panic Button is an emergency button that can only be used in stress Situations where you feel in danger or someone is about to attack you once you press this button it will automatically get your current location and sends it to the contacts and emails of your choosing'),
//             //                 actions: [
//             //                   TextButton(
//             //                       child: Text('Close'),
//             //                       onPressed: () {
//             //                         Navigator.pop(context);
//             //                       }),
//             //                   TextButton(
//             //                     child: Text(
//             //                         'I have read and agreed to all the terms and condations'),
//             //                     onPressed: () {
//             //                       Navigator.pop(context);
//             //                     },
//             //                   )
//             //                 ],
//             //               ));
//             //     }),

//             ));
//   }


