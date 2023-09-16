// import 'dart:js';

// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';

// import 'google_auth_api.dart';


// class sendEmail {

//   sendEmail()  {
//       final user =  GoogleAuthApi.signIn();
//       if (user == null) ;
//       final email = 'khaledkandli55@gmail.com';
//       final accessToken = '';
//       final smptServer = gmailSaslXoauth2(email, accessToken);
//       final message = Message()
//         ..from = Address(email, 'Khaled')
//         ..recipients = ['khaledkandli55@gmail.com']
//         ..subject = 'Hello'
//         ..text = 'this is atext email';
//       try {
//          send(message, smptServer);
//         showSnackBar('sent successfully');
//       } on MailerException catch (erorr) {
//         print(erorr);
//       }
//     }
//   }
// void showSnackBar(String text) {
//     final snackBar = SnackBar(
//       content: Text(
//         text,
//         style: TextStyle(fontSize: 20),
//       ),
//       backgroundColor: Colors.green,
//     );
//     ScaffoldMessenger.of(context)
//       ..removeCurrentSnackBar()
//       ..showSnackBar(snackBar);
//   }
