import 'package:flutter/material.dart';
import 'package:agrarian/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:agrarian/models/user.dart';

class HomeDrawer extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onPageSelected;

  const HomeDrawer(
      {super.key, required this.selectedIndex, required this.onPageSelected});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<UserProfile?>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 250,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green[900],
              ),
              child: userProfile == null
                  ? Center(
                      child: Text(
                        'Guest',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: userProfile.profilePicURL.isNotEmpty
                              ? NetworkImage(userProfile.profilePicURL)
                              : AssetImage('assets/no_image.jpg')
                                  as ImageProvider,
                          radius: 25,
                        ),
                        SizedBox(height: 20),
                        Text(
                          userProfile.userName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          userProfile.location,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          userProfile.bio,
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
            child: userProfile == null
                ? Column(
                    children: [
                      _drawerButton(Icons.group, 'Community',
                          () => widget.onPageSelected(0)),
                      _drawerButton(Icons.school, 'Skill-Up',
                          () => widget.onPageSelected(1)),
                      _drawerButton(Icons.handshake, 'Barter',
                          () => widget.onPageSelected(2)),
                      Divider(),
                      _drawerButton(Icons.settings, 'Settings', () async {}),
                      _drawerButton(Icons.logout, 'Sign Out', () async {
                        await _auth.signOut();
                      }),
                    ],
                  )
                : Column(
                    children: [
                      _drawerButton(Icons.group, 'Community',
                          () => widget.onPageSelected(0)),
                      _drawerButton(Icons.school, 'Skill-Up',
                          () => widget.onPageSelected(1)),
                      _drawerButton(Icons.handshake, 'Barter',
                          () => widget.onPageSelected(2)),
                      _drawerButton(Icons.message, 'Messages',
                          () => widget.onPageSelected(3)),
                      _drawerButton(Icons.notifications, 'Notifications',
                          () => widget.onPageSelected(4)),
                      Divider(),
                      _drawerButton(Icons.settings, 'Settings', () async {}),
                      _drawerButton(Icons.logout, 'Sign Out', () async {
                        await _auth.signOut();
                      }),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _drawerButton(IconData icon, String label, VoidCallback onTap) {
    return Builder(builder: (context) {
      return ListTile(
          leading: Icon(icon, color: Colors.green[900], size: 25),
          title: Text(
            label,
            style: TextStyle(
              color: Colors.green[900],
              fontSize: 16.0,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            onTap();
          });
    });
  }
}
