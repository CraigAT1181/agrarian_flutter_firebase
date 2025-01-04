import 'package:flutter/material.dart';
import 'package:agrarian/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:agrarian/models/user.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<UserProfile?>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Agrarian'),
        backgroundColor: Colors.green[900],
        foregroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          TextButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: Row(
                children: [
                  Icon(Icons.person, color: Colors.white),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Sign out',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 250,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green[900],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/no_image.jpg',
                      ),
                      radius: 30,
                    ),
                    SizedBox(height: 20),
                    Text(
                      userProfile?.userName ?? 'Guest',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      userProfile?.location ?? '',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      userProfile?.bio ?? '',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 20, 32, 20),
              child: Column(
                children: [
                  TextButton(
                      onPressed: () async {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.eco,
                            color: Colors.green[900],
                            size: 25,
                          ),
                          const SizedBox(
                            width: 40.0,
                          ),
                          Text(
                            'Allotment',
                            style: TextStyle(
                              color: Colors.green[900],
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      )),
                  TextButton(
                      onPressed: () async {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.apartment,
                            color: Colors.green[900],
                            size: 25,
                          ),
                          const SizedBox(
                            width: 40.0,
                          ),
                          Text(
                            'Town',
                            style: TextStyle(
                              color: Colors.green[900],
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      )),
                  TextButton(
                      onPressed: () async {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.bookmark,
                            color: Colors.green[900],
                            size: 25,
                          ),
                          const SizedBox(
                            width: 40.0,
                          ),
                          Text(
                            'Bookmarks',
                            style: TextStyle(
                              color: Colors.green[900],
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      )),
                  TextButton(
                      onPressed: () async {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.message,
                            color: Colors.green[900],
                            size: 25,
                          ),
                          const SizedBox(
                            width: 40.0,
                          ),
                          Text(
                            'Messages',
                            style: TextStyle(
                              color: Colors.green[900],
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      )),
                  TextButton(
                      onPressed: () async {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.notifications,
                            color: Colors.green[900],
                            size: 25,
                          ),
                          const SizedBox(
                            width: 40.0,
                          ),
                          Text(
                            'Notifications',
                            style: TextStyle(
                              color: Colors.green[900],
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      )),
                  Divider(),
                  TextButton(
                      onPressed: () async {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.settings,
                            color: Colors.green[900],
                            size: 25,
                          ),
                          const SizedBox(
                            width: 40.0,
                          ),
                          Text(
                            'Settings',
                            style: TextStyle(
                              color: Colors.green[900],
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      )),
                  TextButton(
                      onPressed: () async {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.green[900],
                            size: 25,
                          ),
                          const SizedBox(
                            width: 40.0,
                          ),
                          Text(
                            'Sign Out',
                            style: TextStyle(
                              color: Colors.green[900],
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            )
          ],
        ),
      ),
      // body: Allotment(),
    );
  }
}
