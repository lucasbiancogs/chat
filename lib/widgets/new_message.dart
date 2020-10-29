import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  String _enteredMessage = '';

  Future<void> _sendMessage() async  {
    FocusScope.of(context).unfocus();

    final fbm = FirebaseMessaging();

    final String token = await fbm.getToken();
    print(token);

    final User user = FirebaseAuth.instance.currentUser;

    final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    FirebaseFirestore.instance.collection('chats').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'userName': userData['name'],
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Theme.of(context).primaryColor,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 35,
              margin: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              child: TextField(
                controller: _controller,
                cursorHeight: 25,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 17.5
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17.5))),
                onChanged: (value) {
                  setState(() {
                    _enteredMessage = value;
                  });
                },
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
