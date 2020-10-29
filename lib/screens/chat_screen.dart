import 'package:chat/widgets/messages.dart';
import 'package:chat/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    super.initState();
    
    final fbm = FirebaseMessaging();

    fbm.configure(
      onMessage: (msg) {
        print('onMessage... $msg');
        return Future.value();
      },
      onResume: (msg) {
        print('onResume... $msg');
        return Future.value();
      },
      onLaunch: (msg) {
        print('onLaunch... $msg');
        return Future.value();
      },
    );

    fbm.subscribeToTopic('chats');

    fbm.requestNotificationPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                icon: Icon(Icons.settings,
                    color: Theme.of(context).primaryIconTheme.color),
                items: [
                  DropdownMenuItem(
                    value: 'logout',
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.exit_to_app),
                          SizedBox(width: 8),
                          Text('Sair')
                        ],
                      ),
                    ),
                  ),
                ],
                onChanged: (item) {
                  if (item == 'logout') FirebaseAuth.instance.signOut();
                },
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
