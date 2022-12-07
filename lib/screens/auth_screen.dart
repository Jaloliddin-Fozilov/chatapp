import 'package:chatapp/widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  void _getUserDetails(
      String email, String username, String password, bool isLogin) async {
    UserCredential _userCredential;
    try {
      if (isLogin) {
        _userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        _userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    } on FirebaseException catch (e) {
      var message =
          'Kechirasiz, ma\'lumotlarda xatolilk. Qaytadan urinib ko\'ring.';
      if (e.message! != null) {
        message = e.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(message),
              ElevatedButton(
                onPressed: () =>
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                child: const Text('Ok'),
              )
            ],
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_getUserDetails),
    );
  }
}
