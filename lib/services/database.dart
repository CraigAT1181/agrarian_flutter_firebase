import 'package:agrarian/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // Collection references
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference locationCollection =
      FirebaseFirestore.instance.collection('locations');

  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('posts');

  // Function: Used for both initial registration and later updates
  Future<void> updateUserData(String userName, String email, String? publicUrl,
      String location, String bio) async {
    try {
      // Step 1: Query location
      QuerySnapshot locationSnapShot = await locationCollection
          .where('name', isEqualTo: location)
          .limit(1)
          .get();

      print('locationSnapshot: $locationSnapShot');
      // Step 2: Get location data
      Map<String, dynamic> locationData;
      if (locationSnapShot.docs.isNotEmpty) {
        locationData =
            locationSnapShot.docs.first.data() as Map<String, dynamic>;
        locationData['id'] = locationSnapShot.docs.first.id;
      } else {
        DocumentReference newLocation = await locationCollection.add({
          'name': location,
          'createdAt': FieldValue.serverTimestamp(),
        });

        locationData = {'id': newLocation.id, 'name': location};
      }

      // Step 5: Add the new user document to the users collection
      return await userCollection.doc(uid).set({
        'userName': userName,
        'email': email,
        'profilePic': publicUrl,
        'location': locationData['name'],
        'bio': bio
      });
    } catch (e) {
      print('Error updating user data: $e');
      rethrow;
    }
  }

  Future<UserProfile?> getUserProfile() async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        return UserProfile(
            userName: userDoc['userName'],
            email: userDoc['email'],
            profilePicURL: userDoc['profilePic'],
            location: userDoc['location'],
            bio: userDoc['bio']);
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
    return null;
  }

  Stream<UserProfile?> userProfileStream() {
    return userCollection.doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return UserProfile(
            userName: snapshot['userName'],
            email: snapshot['email'],
            profilePicURL: snapshot['profilePic'],
            location: snapshot['location'],
            bio: snapshot['bio']);
      } else {
        return null;
      }
    });
  }

  // Stream<List<Map<String, dynamic>>> getPosts() {
  //   return postCollection
  //       .orderBy('createdBy', descending: true)
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs
  //           .map((doc) => doc.data() as Map<String, dynamic>)
  //           .toList());
  // }
}
