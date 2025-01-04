class Post {
  final String uid;
  final String userId;
  final String parentId;
  final String content;
  final DateTime createdAt;

  Post(
      {required this.uid,
      required this.userId,
      required this.parentId,
      required this.content,
      required this.createdAt});

  factory Post.fromMap(Map<String, dynamic> data) {
    return Post(
      uid: data['uid'],
      userId: data['userId'],
      parentId: data['parentId'],
      content: data['content'],
      createdAt: data['createdAt'],
    );
  }
}
