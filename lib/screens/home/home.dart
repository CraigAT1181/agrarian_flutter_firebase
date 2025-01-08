import 'package:agrarian/screens/bartering/bartering.dart';
import 'package:agrarian/screens/community/community.dart';
import 'package:agrarian/screens/home/bottom_navigation.dart';
import 'package:agrarian/screens/home/home_drawer.dart';
import 'package:agrarian/screens/messages/messages.dart';
import 'package:agrarian/screens/notifications/notifications.dart';
import 'package:agrarian/screens/skill_up/skill_up.dart';
import 'package:flutter/material.dart';
import 'package:agrarian/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:agrarian/models/user.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  int selectedIndex = 0;

  // Example pages
  final List<Widget> _pages = [
    Community(),
    SkillUp(),
    Bartering(),
    Messages(),
    Notifications(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<UserProfile?>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child: ClipOval(
                    child: userProfile?.profilePicURL != null &&
                            userProfile!.profilePicURL.isNotEmpty
                        ? Image.network(
                            userProfile.profilePicURL,
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          )
                        : Image.asset(
                            'assets/no_image.jpg',
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          ),
                  ),
                )),
          ),
          title: Text('Agrarian'),
          backgroundColor: Colors.green[900],
          foregroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () async {
                          await _auth.signOut();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              'Sign out',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ))
                  ],
                )),
          ],
        ),
        drawer: HomeDrawer(
            selectedIndex: selectedIndex, onPageSelected: onItemTapped),
        body: _pages[selectedIndex],
        bottomNavigationBar: BottomNavBar(
            onItemTapped: onItemTapped, selectedIndex: selectedIndex));
  }
}
