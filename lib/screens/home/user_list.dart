import 'package:agrarian/models/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:agrarian/models/user_profile.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<UserProfile>?>(context);

    users?.forEach((user) {
      print(user.userName);
      print(user.profilePic);
      print(user.town['name']);
      print(user.allotment['name']);
    });

    return Container();
  }
}
