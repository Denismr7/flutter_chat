import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents =
              (snapshot.data as QuerySnapshot<Map<String, dynamic>>).docs;
          final currentUser = FirebaseAuth.instance.currentUser;
          return ListView.builder(
            reverse: true,
            itemCount: documents.length,
            itemBuilder: (ctx, index) => MessageBubble(
              key: ValueKey(documents[index].id),
              message: documents[index]['text'],
              username: documents[index]['username'],
              userImage: documents[index]['user_image'],
              isMe:
                  documents[index]['userId'] == currentUser!.uid ? true : false,
            ),
          );
        });
  }
}
