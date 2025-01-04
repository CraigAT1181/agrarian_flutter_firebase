import 'package:flutter/material.dart';

class LocationFeed extends StatefulWidget {
  const LocationFeed({super.key});

  @override
  State<LocationFeed> createState() => _LocationFeedState();
}

class _LocationFeedState extends State<LocationFeed> {
  @override
  Widget build(BuildContext context) {
    return Center(child: const Text('Location Feed.'));
  }
}
