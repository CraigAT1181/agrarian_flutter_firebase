// import 'package:agrarian/models/post.dart';
// import 'package:agrarian/shared/loading.dart';
// import 'package:flutter/material.dart';
// import 'package:agrarian/services/database.dart';
// import 'post_card.dart';

// class PostList extends StatelessWidget {
//   const PostList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<Map<String, dynamic>>>(
//       stream: DatabaseService().getPosts(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Loading();
//         }

//         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Center(child: Text('No posts available'));
//         }

//         final posts = snapshot.data!;

//         return ListView.builder(
//             itemCount: posts.length,
//             itemBuilder: (context, index) {
//               final postData = posts[index];
//               final post = Post.fromMap(postData);
//               return PostCard(post: post);
//             });
//       },
//     );
//   }
// }
