import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:agrarian/services/auth.dart';
import 'package:agrarian/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agrarian/screens/home/user_list.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot?>.value(
      value: DatabaseService().users,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Agrarian'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.green[800],
          elevation: 0.0,
          actions: <Widget>[
            TextButton(
                onPressed: () async {
                  await _auth.signOut();
                },
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.green[800]),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Sign out',
                      style: TextStyle(color: Colors.green[800]),
                    ),
                  ],
                ))
          ],
        ),
        body: UserList(),
      ),
    );
  }
}
