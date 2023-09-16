//import 'package:firebase/screens/registration_screen.dart';
//import 'package:firebase/screens/signin_screen.dart';
import 'package:flutter/material.dart';

import '../singnin_screen/signin_screen.dart';
import '../widgets/my_button.dart';
import 'registration_screen.dart';

class WelecomScreen extends StatefulWidget {
  // WelecomScreen({Key? key}) : super(key: key);
  static const String screenRoute = 'welecome_screen';
  @override
  State<WelecomScreen> createState() => _WelwcomScreenState();
}

class _WelwcomScreenState extends State<WelecomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  child: Image.asset('images/finallogo.png'),
                  height: 300,
                ),
                Text(
                  'Survival app',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Color(0xff2e386b)),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            MyButton(
              color: Colors.yellow[900]!,
              title: 'Sign in',
              onPressed: () {
                Navigator.pushNamed(context, SignInScreen.screenRoute);
              },
            ),
            //  IconButton(
            //    onPressed: (){},
            //    icon: Icon(Icons.login),
            //    tooltip: 'Log in',
            //    ),
            SizedBox(
              height: 30,
            ),
            MyButton(
                color: Colors.blue[800]!,
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.screenRoute);
                },
                title: 'Sign up')
          ],
        ),
      ),
    );
  }
}
