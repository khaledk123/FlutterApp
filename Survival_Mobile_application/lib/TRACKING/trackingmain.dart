import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:google_map_live/mymap.dart';
import 'package:location/location.dart' as instlocation;
import 'package:permission_handler/permission_handler.dart';

import 'mymap.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(home: MyApp()));
// }

// ignore: camel_case_types
class mapscreate extends StatefulWidget {
  const mapscreate({Key? key}) : super(key: key);

  @override
  _mapscreateState createState() => _mapscreateState();
}

// ignore: camel_case_types
class _mapscreateState extends State<mapscreate> {
  final instlocation.Location location = instlocation.Location();
  StreamSubscription<instlocation.LocationData>? _locationSubscription;

  @override //main setstate
  void initState() {
    super.initState();
    _requestPermission();
    location.changeSettings(
        interval: 300, accuracy: instlocation.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('live location tracker'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, //center screen and stretch
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 200,
                child: Image.asset('images/finallogo.png'),
              ),
              IconButton(
                  icon: const Icon(Icons.gps_fixed),
                  onPressed: () {
                    _getLocation();
                  }),
              // TextButton(
              //     onPressed: () {
              //       _getLocation();
              //     },
              //     child: Text('add my location to firebase')),
              TextButton(
                  onPressed: () {
                    _listenLocation();
                  },
                  child: const Text('enable live location Tracking')),
              TextButton(
                  onPressed: () {
                    _stopListening();
                  },
                  child: const Text('stop anyone from tracking live location')),
              Expanded(
                  child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('location')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              snapshot.data!.docs[index]['name'].toString()),
                          subtitle: Row(
                            children: [
                              Text(snapshot.data!.docs[index]['latitude']
                                  .toString()),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(snapshot.data!.docs[index]['longitude']
                                  .toString()),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.directions),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      MyMap(snapshot.data!.docs[index].id)));
                            },
                          ),
                        );
                      });
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  _getLocation() async {
    //main gps button
    try {
      final instlocation.LocationData _locationResult =
          await location.getLocation();
      await FirebaseFirestore.instance.collection('location').doc('user1').set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
        'name': 'khaledserver'
      }, SetOptions(merge: true));
    } catch (erorr) {
      // ignore: avoid_print
      print(erorr);
    }
  }

  Future<void> _listenLocation() async {
    //frist main funtion
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      // ignore: avoid_print
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((instlocation.LocationData currentlocation) async {
      await FirebaseFirestore.instance.collection('location').doc('user1').set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': 'khaledserver'
      }, SetOptions(merge: true));
    });
  }

  _stopListening() {
    //second main funtion
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  _requestPermission() async {
    //third main funtion
    var status = await Permission.location.request();
    if (status.isGranted) {
      // ignore: avoid_print
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
