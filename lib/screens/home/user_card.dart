import 'package:flutter/material.dart';
import 'package:agrarian/models/user.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.user});

  final UserProfile? user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              ClipOval(
                child: _isValidUrl(user?.profilePic)
                    ? Image.network(
                        user!.profilePic,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/no_image.jpg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(height: 16.0),
              // User Name
              Text(
                user?.userName ?? 'Unknown',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              // Town and Allotment
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    user?.town['name'] ?? 'Unknown Town',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    user?.allotment['name'] ?? 'Unknown Allotment',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool _isValidUrl(String? url) {
  if (url == null || url.isEmpty) {
    return false;
  }
  final uri = Uri.tryParse(url);
  return uri != null && uri.hasScheme && uri.hasAuthority;
}
