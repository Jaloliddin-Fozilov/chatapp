import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats/HIz7ulwaKZ31BCTTmqp7/messages')
              .snapshots(),
          builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final docs = streamSnapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (ctx, i) => Container(
                padding: const EdgeInsets.all(8),
                child: Text(docs[i]['text']),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.get_app),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/HIz7ulwaKZ31BCTTmqp7/messages')
              .add(
            {
              'text': 'newMessage',
            },
          );
        },
      ),
    );
  }
}
