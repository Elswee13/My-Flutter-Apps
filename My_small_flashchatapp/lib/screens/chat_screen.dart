import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Creating the instance for the cloud firestore, will use a private variable.
final _firestore = FirebaseFirestore.instance;

//Variable to get the logged user.
FirebaseAuth? loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //creating a message text controller to clear the texting box
  final messageTextController = TextEditingController();
  //Creating the instance for the firebase authorization, will use a private variable.
  final _auth = FirebaseAuth.instance;

  late String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    future:
    Firebase.initializeApp();
  }

//method to get the current user
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser!;
      //to verify the logged user is registered.
      if (user != null) {
        loggedInUser = user as FirebaseAuth;
      }
    } catch (e) {
      print(e);
    }
  }

//method to get the messages but only works using a button to pull them
//   void getMessages() async {
//     final messages = await _firestore.collection('messages').get();
//     for (var messages in messages.docs) {
//       print(messages.data());
//     }
//   }

//second method to get messages but using the stream
  void messagesStream() async {
    await for (var snapshot in _firestore.collection("messages").snapshots()) {
      for (var messages in snapshot.docs) {
        print(messages.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);

                //logout the user
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                        //messagetext variable to keep the information
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //to clear the textbox
                      messageTextController.clear();
                      //messagetext + LoggedUser.email
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': _auth.currentUser!.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      //   //advice the snapshot from this code is not the same for the snapshot used in
      //   //firebase snapshot.
      builder: (context, snapshot) {
        List<MessageBubble> messageBubbles = [];
        //this is to show a circle progress indicator to check if there any data.
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        //this variable will be used to access async snapshot data.
        final messages = snapshot.data!.docs.reversed;

        for (var message in messages) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          final currentuser = loggedInUser?.currentUser!;

          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentuser == messageSender,
          );

          messageBubbles.add(messageBubble);
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.sender, required this.text, required this.isMe});
  final String? sender;
  final String? text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            //isME ? when is added is like a if statement
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$sender',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12.0,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
            elevation: 5.0,
            //isME ? when is added is like a if statement
            color: isMe ? Colors.blueAccent : Colors.greenAccent,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Text(
                '$text',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
