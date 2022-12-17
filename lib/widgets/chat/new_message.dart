import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _formKey = GlobalKey<FormState>();

  final _messageTextController = TextEditingController();

  String? _message;

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();

    if (_message != null && _message!.trim().isNotEmpty) {
      final user = FirebaseAuth.instance.currentUser;
      // send message
      FirebaseFirestore.instance.collection('chats').add(
        {
          'text': _message,
          'createdAt': Timestamp.now(),
          'userId': user!.uid,
        },
      );
      _messageTextController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(top: 8),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Yangi xabar yozing...'),
                onSaved: (newValue) {
                  _message = newValue;
                },
                controller: _messageTextController,
              ),
            ),
            IconButton(
              onPressed: _sendMessage,
              icon: Icon(
                Icons.send,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
