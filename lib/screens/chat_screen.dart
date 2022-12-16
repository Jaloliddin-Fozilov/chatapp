import 'package:chatapp/widgets/chat/messages.dart';
import 'package:chatapp/widgets/chat/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter chat app'),
        actions: [
          DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                    value: 'logout',
                    child: Row(
                      children: const [
                        Icon(Icons.exit_to_app),
                        SizedBox(width: 8),
                        Text('Chiqish'),
                      ],
                    ))
              ],
              onChanged: ((selectedItem) {
                if (selectedItem == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              }))
        ],
      ),
      body: Column(
        children: [
          const Expanded(
            child: Messages(),
          ),
          NewMessage(),
        ],
      ),
    );
  }
}
