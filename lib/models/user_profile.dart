class UserProfile {
  final String userName;
  final String profilePic;
  final Map<String, dynamic> town;
  final Map<String, dynamic> allotment;

  UserProfile(
      {required this.userName,
      required this.profilePic,
      required this.town,
      required this.allotment});
}
