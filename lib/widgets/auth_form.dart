import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Function getUserDetails;
  const AuthForm(this.getUserDetails, {super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  final _userData = {'email': '', 'username': '', 'password': ''};

  bool _isLogin = true;

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.getUserDetails(
        _userData['email']!.trim(),
        _userData['username']!.trim(),
        _userData['password']!.trim(),
        _isLogin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: const ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email manizilingiz',
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Iltimos, to\'g\'ri email manzil kiriting';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _userData['email'] = newValue!;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 4) {
                          return 'Iltimos, 4ta harfdan oshgan username kiriting';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _userData['username'] = newValue!;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Parolingiz',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 7) {
                        return 'Iltimos, 7ta harfdan oshgan parol kiriting';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _userData['password'] = newValue!;
                    },
                    obscureText: true,
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(_isLogin ? 'Kirish' : 'Ro\'yxatdan o\'tish'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(!_isLogin ? 'Kirish' : 'Ro\'yxatdan o\'tish'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
