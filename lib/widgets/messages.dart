import 'package:chat/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LinearProgressIndicator(),
          );
        }

        final List<dynamic> chatDocs = chatSnapshot.data.docs;

        return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (ctx, i) {
              final bool messageBelongsToMe =
                  FirebaseAuth.instance.currentUser.uid ==
                      chatDocs[i]['userId'];
              
              final bool isFirstMessage =
                i == chatDocs.length - 1
                || chatDocs[i]['userId'] != chatDocs[i + 1]['userId'];

              final bool isLastMessage =
                i == 0
                || chatDocs[i]['userId'] != chatDocs[i - 1]['userId'];

              return MessageBubble(
                chatDocs[i]['text'],
                userName: chatDocs[i]['userName'],
                belongsToMe: messageBelongsToMe,
                key: ValueKey(chatDocs[i].id),
                isFirstMessage: isFirstMessage,
                isLastMessage: isLastMessage,
              );
            });
      },
    );
  }
}
