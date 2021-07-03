import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (ctx, index) => Container(
          padding: const EdgeInsets.all(8),
          child: Text('This works'),
        ),
        itemCount: 10,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('/chats/pIoQd36JOVJnGtOdGHsa/messages/')
              .snapshots()
              .listen((event) {
            print(event.docs[0]['text']);
          });
        },
      ),
    );
  }
}
