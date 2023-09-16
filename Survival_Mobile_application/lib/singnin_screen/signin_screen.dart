import 'package:firebase/navigation/curved_tabs.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/my_button.dart';
//import 'chat_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key); //constructor
  static const String screenRoute = 'signin_screen'; //for routing
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth = FirebaseAuth.instance; //for firebase authentication
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    //final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      //resizeToAvoidBottomInset: false,

      backgroundColor:
          Colors.blue, //for controling the sign in screen //change later
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(32),
            reverse: true,
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, //center screen and stretch
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // if(!isKeyboard)
                // ignore: sized_box_for_whitespace
                Container(
                  height: 200,
                  child: Image.asset('images/finallogo.png'),
                ),
                TextFormField(
                  key: const ValueKey('email'),
                  validator: (value) {
                    //to insure accurate entry
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType
                      .emailAddress, //for better keyboard// change later
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //set state
                    email = value;
                  },
                  decoration: const InputDecoration(
                    labelText: ('Your Email'), //hint Text //xhange later
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  // for spacing
                  height: 8,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return 'Password must be at least 7 characters long.';
                    }
                    return null;
                  },
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: const InputDecoration(
                    labelText: ('Password'),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      //highlight
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  //for space
                  height: 10,
                ),
                MyButton(
                    //main
                    color: Colors.blue[800]!,
                    onPressed: () async {
                      try {
                        // ignore: unused_local_variable
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        Navigator.pushNamed(context, curvedNavBar.screenRoute);
                      } catch (erorr) {
                        // ignore: avoid_print
                        print(erorr);
                      }
                    },
                    title: 'Sign in')
              ],
            ),
          )),
    );
  }
}
