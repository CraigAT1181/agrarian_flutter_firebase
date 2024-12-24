import 'package:agrarian/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_card.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<UserProfile>?>(context);

    return ListView.builder(
        itemCount: users?.length,
        itemBuilder: (context, index) {
          return UserCard(user: users?[index]);
        });
  }
}
