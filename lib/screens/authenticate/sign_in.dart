import 'package:agrarian/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        elevation: 0.0,
        title: Text('Welcome back!'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: TextButton(
            onPressed: () async {
              dynamic result = await _auth.signInAnon();

              if (result == null) {
                print('Error signing in.');
              } else {
                print('Signed in.');
                print(result.uid);
              }
            },
            child: Text('Visit as Guest')),
      ),
    );
  }
}
