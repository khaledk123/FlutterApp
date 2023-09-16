import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:firebase/panicButton/panicbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'Registration/registration_screen.dart';
// import 'Registration/welecome_screen.dart';
import 'Emergancy_Contacts/searchBar/search interface.dart';
import 'Registration_screen/registration_screen.dart';
import 'Registration_screen/welecome_screen.dart';
import 'TRACKING/trackingmain.dart';
import 'TRACKING/mymap.dart';
import 'Tips&Tricks/Survival_tips.dart';
import 'Tips&Tricks/deserttips.dart';
import 'chating_app/chat_screen.dart';
import 'emailsender/emailtry.dart';
import 'googlemaps_screens/mainrun.dart';
import 'navigation/curved_tabs.dart';
import 'photo_uploud/test.dart';
import 'screens/contacts.dart';
import 'singnin_screen/signin_screen.dart';
// import 'screens/chat_screen.dart';
// import 'screens/signin_screen.dart';
// import 'screens/welecome_screen.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() async {
  //MapView('AIzaSyCXwsoC3h29csPIeo1n9pi7fV7hau18MwQ');
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // essential to insilaze firebase into the application
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      //home: PanicButton(title: '',)
      //initialRoute: WelecomScreen.screenRoute,
     initialRoute: _auth.currentUser!=null?curvedNavBar.screenRoute:WelecomScreen.screenRoute,
      routes: {
        //'welecome_screen': (context)=>WelecomScreen(),
        WelecomScreen.screenRoute: (context) => WelecomScreen(),
        SignInScreen.screenRoute: (context) => SignInScreen(),
        RegistrationScreen.screenRoute: (context) => RegistrationScreen(),
        curvedNavBar.screenRoute: (context) => curvedNavBar(),
        ChatScreen.screenRoute: (context) => ChatScreen(),
      },
    //onPressed: (){Navigator.pushNamed(context, '/map')
     );
   }
 }

// class MyHomePage extends StatefulWidget {

// }
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
 //   );
 // }
//}
