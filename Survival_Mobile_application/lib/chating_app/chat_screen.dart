import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
late User singedInUser;

class ChatScreen extends StatefulWidget {
  // ChatScreen({Key? key}) : super(key: key);
  static const String screenRoute = 'chat_screen';
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String? messageText; //to remove error
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    //to check if theuser is loged in
    try {
      final user = _auth.currentUser;
      if (user != null) {
        //means that the user has loged in

        singedInUser = user;
        print(singedInUser.email); //to make sure of the user email
      }
    } catch (erorr) {
      print(erorr);
    }
  }

  // void getMessages() async {
  //   final messages = await _firestore.collection('messages').get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }
  // void messagesStreams() async {
  //   await for (var snapshots in _firestore.collection('messages').snapshots()) {
  //     for (var messages in snapshots.docs) {
  //       print(messages.data());
  //     }
  //   }
  //   ;
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Row(
          children: [
            Image.asset(
              'images/logo.jpeg.jpg',
              height: 25,
            ),
            SizedBox(
              width: 10,
            ),
            Text('Messages')
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                // messagesStreams();
                _auth.signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.close))
        ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MessageStreamBuilder(),
          // StreamBuilder<QuerySnapshot>(
          //   stream: _firestore.collection('messages').snapshots(),
          //   builder: (context, snapshot) {
          //     //List<Text> messageWidgets = [];
          //     List<MessageLine> messageWidgets = [];

          //     if (!snapshot.hasData) {
          //       return const Center(
          //         child: CircularProgressIndicator(
          //           backgroundColor: Colors.blue,
          //         ),
          //       );
          //     }

          //     final messages = snapshot.data!.docs;
          //     for (var message in messages) {
          //       final messageText = message.get('text');
          //       final messageSender = message.get('sender');
          //       final messageWidget = MessageLine(
          //         sender: messageSender,
          //         text: messageText,
          //       );
          //       //Text('$messageText - $messageSender',
          //       // style: TextStyle(fontSize: 30),
          //       // );
          //       messageWidgets.add(messageWidget);
          //     }
          //     return Expanded(
          //       child: Padding(
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          //         child: ListView(
          //           children: messageWidgets,
          //         ),
          //       ),
          //     );
          //   },
          // ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.orange,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: TextField(
                  controller: messageTextController,
                  onChanged: (value) {
                    messageText = value;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10, //for the text box
                      horizontal: 25,
                    ),
                    hintText: 'messages',
                    border: InputBorder.none,
                  ),
                )),
                //
                IconButton(
                  onPressed: () {
                    messageTextController.clear();
                    _firestore.collection('messages').add({
                      'text': messageText,
                      'sender': singedInUser.email,
                      'time': FieldValue.serverTimestamp(),
                    });
                  },
                  icon: Icon(Icons.send), //for the text button
                  color: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  iconSize: 30,
                ),
                IconButton(onPressed: (){}, icon: Icon(Icons.circle_rounded, color: Colors.red,))
              ],
            ),
          )
        ],
      )),
      // class Name {

      // }
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        //List<Text> messageWidgets = [];
        List<MessageLine> messageWidgets = [];

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        }

        final messages = snapshot.data!.docs.reversed;
        for (var message in messages) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          final currentUser = singedInUser.email;

          // if (currentUser == messageSender) {}
          final messageWidget = MessageLine(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );

          //Text('$messageText - $messageSender',
          // style: TextStyle(fontSize: 30),
          // );
          messageWidgets.add(messageWidget);
        }
        return Expanded(
          // child: Padding(
          //   padding: const EdgeInsets.symmetric(
          //       horizontal: 10, vertical: 20), //for the aliment of the text
          child: ListView(
            reverse: true, //for the screen to always be down
            children: messageWidgets,
            padding: EdgeInsets.all(10.0),
          ),
          //  ),
        );
      },
    );
  }
}

@override
class MessageLine extends StatelessWidget {
  const MessageLine(
      {required this.sender, required this.text, required this.isMe, Key? key})
      : super(key: key);
  final String? sender;
  final String? text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              '$sender',
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Material(
                  elevation: 5,
                  borderRadius: isMe
                      ? BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))
                      : BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                  color: isMe ? Colors.blue[800] : Colors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      '$text',
                      style: TextStyle(
                          fontSize: 20,
                          color: isMe ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
