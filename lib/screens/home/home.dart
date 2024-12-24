import 'package:agrarian/screens/allotment/allotment.dart';
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
        backgroundColor: Colors.green[800],
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
                  color: Colors.green[800],
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
                      userProfile!.userName,
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
                      userProfile.town['name'],
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      userProfile.allotment['name'],
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
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Icon(Icons.eco),
                    SizedBox(width: 40.0),
                    Text('Allotment'),
                  ]),
                  SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Icon(Icons.apartment),
                    SizedBox(width: 40.0),
                    Text('Town'),
                  ]),
                  SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Icon(Icons.bookmark),
                    SizedBox(width: 40.0),
                    Text('Bookmarks'),
                  ]),
                  SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Icon(Icons.message),
                    SizedBox(width: 40.0),
                    Text('Messages'),
                  ]),
                  SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Icon(Icons.notifications),
                    SizedBox(width: 40.0),
                    Text('Notifications'),
                  ]),
                  SizedBox(height: 20),
                  Divider(),
                  SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Icon(Icons.settings),
                    SizedBox(width: 40.0),
                    Text('Settings')
                  ]),
                  SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Icon(Icons.logout),
                    SizedBox(width: 40.0),
                    Text('Sign Out')
                  ]),
                ],
              ),
            )
          ],
        ),
      ),
      body: Allotment(),
    );
  }
}
