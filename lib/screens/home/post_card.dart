import 'package:flutter/material.dart';
import 'package:agrarian/models/post.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post? post;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(post!.content),
    );
  }
}
