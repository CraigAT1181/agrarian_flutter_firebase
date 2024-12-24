import 'package:agrarian/models/user.dart';
import 'package:agrarian/screens/authenticate/authenticate.dart';
import 'package:agrarian/screens/home/home.dart';
import 'package:agrarian/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AgrarianUser?>(context);

    if (user == null) {
      return const Authenticate();
    } else {
      return StreamProvider<UserProfile?>.value(
          initialData: null,
          value: DatabaseService(uid: user.uid).userProfileStream(),
          child: Home());
    }
  }
}
