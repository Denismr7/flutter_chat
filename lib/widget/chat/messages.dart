import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          return ListView.builder(
            reverse: true,
            itemCount: documents.length,
            itemBuilder: (ctx, index) => Text(documents[index]['text']),
          );
        });
  }
}
