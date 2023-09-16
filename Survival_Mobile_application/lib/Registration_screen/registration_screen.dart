//import 'package:firebase/screens/chat_screen.dart';
import 'package:firebase/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import '../chating_app/chat_screen.dart';
import '../singnin_screen/signin_screen.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  //RegistrationScreen({Key? key}) : super(key: key);
  static const String screenRoute = 'registration_screen'; //for routing
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late File _file;
  final _auth = FirebaseAuth.instance; //for connenting with firebase
  late String email; //won't have a value
  late String password; //won't have a value
  //bool showSpinner = false;
  Future Pickercamera() async {
    // ignore: deprecated_member_use
    final myfile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      _file = File(myfile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    //final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
        backgroundColor: Colors.blue, //change later
        // body: ModalProgressHUD(
        //   inAsyncCall: showSpinner,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(32),
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // if(!isKeyboard)
                // ignore: sized_box_for_whitespace
                Container(
                  height: 200,
                  child: Image.asset('images/finallogo.png'),
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  keyboardType:
                      TextInputType.emailAddress, //for better keyboard
                  autocorrect: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: const InputDecoration(
                    hintText: ('Your Email'),
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
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  keyboardType:
                      TextInputType.emailAddress, //for better keyboard
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: const InputDecoration(
                    hintText: ('Password'),
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
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType:
                      TextInputType.emailAddress, //for better keyboard
                  // obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: const InputDecoration(
                    hintText: ('Phone Number'),
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
                //IconButton(onPressed: Pickercamera, icon: Icon(Icons.photo)),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(onSurface: Colors.blue),
                    child: Text('Uploud Image'),
                    onPressed: Pickercamera),
                MyButton(
                    color: Colors.blue[800]!,
                    onPressed: () async {
                      //we added 'async' so the user cant login without entring the correct information and authentication is achived
                      // print(
                      //   email,
                      // );
                      // print(password);
                      //

                      try {
                        //added try and catch error managment condition to fix error in login by the user
                        final newUser = await _auth.createUserWithEmailAndPassword(
                            //for creating a new email and password to th values 'email','password' assined
                            email: email,
                            password: password);
                        Navigator.pushNamed(context, SignInScreen.screenRoute);
                      } catch (erorr) {
                        print(erorr);
                      }
                    },
                    title: 'Reister'),
              ],
            ),
          ),
        ));
    //);
  }
}
