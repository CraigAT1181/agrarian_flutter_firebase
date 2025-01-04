class AgrarianUser {
  final String uid;

  AgrarianUser({required this.uid});
}

class UserProfile {
  final String userName;
  final String email;
  final String profilePicURL;
  final String location;
  final String bio;

  UserProfile(
      {required this.userName,
      required this.email,
      required this.profilePicURL,
      required this.location,
      required this.bio});
}
