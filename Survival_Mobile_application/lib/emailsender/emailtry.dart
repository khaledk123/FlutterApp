// ignore_for_file: dead_code
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'google_auth_api.dart';

class emailsend extends StatefulWidget {
  final String sendEmail;
  emailsend(
    Key? key,
    this.sendEmail,
  ) : super(key: key);

  @override
  State<emailsend> createState() => _MainPageState();
}

class _MainPageState extends State<emailsend> {
  get sendEmail => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('email'),
        centerTitle: true,
      ),
      body: Center(
        child: IconButton(
            icon: const Icon(Icons.circle_rounded),
            splashColor: Colors.red,
            color: Colors.red,
            iconSize: 250,
            onPressed: () {
              sendEmail();
            }),
      ),
    );

    //   sendEmail() async {
    //   final user = await GoogleAuthApi.signIn();
    //   if (user == null) return;
    //   final email = 'khaledkandli55@gmail.com';
    //   final auth = await user.authentication;
    //   final accessToken = '';
    //   final smptServer = gmailSaslXoauth2(email, accessToken);
    //   final message = Message()
    //     ..from = Address(email, 'Khaled')
    //     ..recipients = ['khaledkandli55@gmail.com']
    //     ..subject = 'Hello'
    //     ..text = 'this is atext email';
    //   try {
    //     await send(message, smptServer);
    //     showSnackBar('sent successfully');
    //   } on MailerException catch (erorr) {
    //     print(erorr);
    //   }
    // }
  }

  void showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
// child: ElevatedButton(
        //     style: ElevatedButton.styleFrom(
        //       padding: EdgeInsets.all(20),
        //       textStyle: TextStyle(fontSize: 24),
        //     ),
        //     child: Text('sendmail'),
        //     onPressed: sendEmail,
        // )