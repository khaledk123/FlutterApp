// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapPage extends StatefulWidget {
//   @override
//   _MapPageState createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   PolylinePoints polylinePoints;
//   List<LatLng> polylineCoordinates = [];
//   Map<PolylineId, Polyline> polylines = {};
//   GoogleMapController mapController;
//   Set<Marker> _markers={};
//   CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));

//   _getCurrentLocation() async {
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) async {
//       setState(() {
//         _currentPosition = position;
//         _destPos=Position(
//           latitude: _currentPosition.latitude+0.0015,
//           longitude: _currentPosition.longitude, accuracy: null, altitude: null, heading: null, speed: null, speedAccuracy: null, timestamp: null ,
//         );
//         print('CURRENT POS: $_currentPosition');
//         print('DEST POS: $_destPos');
//         mapController.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: LatLng(position.latitude, position.longitude),
//               zoom: 10.0,
//             ),

//           ),
//         );
//       });
//     }).catchError((e) {
//       print(e);
//     });
//   }
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//   void _onCameraMoveStarted()
//   {
//       try {
//         _markers.add(
//             Marker(
//               markerId: MarkerId('start'),
//               position: LatLng(
//                   _currentPosition.latitude, _currentPosition.longitude),
//             )
//         );
//         _markers.add(
//             Marker(
//               markerId: MarkerId('dest'),
//               position: LatLng(
//                   _destPos.latitude, _destPos.longitude),
//             )
//         );
//         Position _northeastCoordinates;
//         Position _southwestCoordinates;
//         if (_currentPosition.latitude <= _destPos.latitude) {
//           _southwestCoordinates = _currentPosition;
//           _northeastCoordinates = _destPos;
//         } else {
//           _southwestCoordinates = _destPos;
//           _northeastCoordinates = _currentPosition;
//         }
//         mapController.animateCamera(
//           CameraUpdate.newLatLngBounds(
//             LatLngBounds(
//               northeast: LatLng(
//                 _northeastCoordinates.latitude,
//                 _northeastCoordinates.longitude,
//               ),
//               southwest: LatLng(
//                 _southwestCoordinates.latitude,
//                 _southwestCoordinates.longitude,
//               ),
//             ),
//             175.0, // padding
//           ),
//         );
//         _createPolylines(_currentPosition, _destPos);
//       }
//       catch(e)
//       {
//         print(e);
//       }
//   }
//   _createPolylines(Position start, Position destination) async {
//     List<LatLng> pnts=[];
//     pnts.add(LatLng(start.latitude, start.longitude),);
//     pnts.add(LatLng(destination.latitude, destination.longitude));
//     polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       'AIzaSyDwPvneP_Kb65nWrMYJ8YeSu52NMp5zO9s',
//       PointLatLng(start.latitude, start.longitude),
//       PointLatLng(destination.latitude, destination.longitude),
//       travelMode: TravelMode.transit,
//     );
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     }
//     PolylineId id = PolylineId('poly');
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: Colors.red,
//       //points: polylineCoordinates,
//       points: pnts,
//       width: 3,
//     );
//     polylines[id] = polyline;
//   }

//   Position _currentPosition,_destPos;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         bottomNavigationBar: BottomAppBar(
//           child: Container(
//             margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 IconButton(
//                   icon: Icon(
//                     Icons.home,
//                     size: 38.0,
//                   ),
//                   onPressed: (){Navigator.pop(context, '/map');},
//                 ),
//                 IconButton(icon: Icon(Icons.map, size: 35.0),onPressed: (){},),
//                 IconButton(icon: Icon(Icons.article, size: 35.0),onPressed: (){Navigator.pop(context, '/map');Navigator.pushNamed(context, '/third');},),
//                 IconButton(icon: Icon(Icons.info_outline, size: 35.0),onPressed: () {Navigator.pop(context, '/map');Navigator.pushNamed(context, '/second');},),
//               ],
//             ),
//           ),
//         ),
//         body: GoogleMap(
//             initialCameraPosition: _initialLocation,
//             myLocationEnabled: true,
//             myLocationButtonEnabled: false,
//             mapType: MapType.normal,
//             zoomGesturesEnabled: true,
//             zoomControlsEnabled: false,
//             onMapCreated: (GoogleMapController controller){
//               mapController = controller;
//             },
//             onCameraMoveStarted: _onCameraMoveStarted,
//             markers: _markers,
//             polylines: Set<Polyline>.of(polylines.values),
//         )
//     );
//   }
// }
