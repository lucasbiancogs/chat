import 'package:chat/screens/loading_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chats').snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          }

          final documents = snapshot.data.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, i) => Container(
              padding: EdgeInsets.all(8),
              child: Text(documents[i]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance.collection('chats').add({
            'text': 'Adicinado manualmente',
          });
        },
      ),
    );
  }
}
