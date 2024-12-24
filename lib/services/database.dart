import 'package:agrarian/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // Collection references
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference townCollection =
      FirebaseFirestore.instance.collection('towns');

  final CollectionReference allotmentCollection =
      FirebaseFirestore.instance.collection('allotments');

  // Function: Used for both initial registration and later updates
  Future updateUserData(String userName, String profilePicPath, String townName,
      String allotmentName) async {
    // Step 1: Query townName
    QuerySnapshot townSnapShot =
        await townCollection.where('name', isEqualTo: townName).limit(1).get();

    // Step 2: Get town data
    Map<String, dynamic>? townData;
    if (townSnapShot.docs.isNotEmpty) {
      townData = townSnapShot.docs.first.data() as Map<String, dynamic>;
      townData['id'] = townSnapShot.docs.first.id;
    } else {
      throw 'Town not found';
    }

    // Step 3: Query the allotment by name within the specific town's sub-collection
    DocumentReference townRef = townSnapShot.docs.first.reference;
    QuerySnapshot allotmentSnapshot = await townRef
        .collection('allotments')
        .where('name', isEqualTo: allotmentName)
        .limit(1)
        .get();

    // Step 4: Get the allotment data
    Map<String, dynamic>? allotmentData;
    if (allotmentSnapshot.docs.isNotEmpty) {
      allotmentData =
          allotmentSnapshot.docs.first.data() as Map<String, dynamic>;
      allotmentData['id'] = allotmentSnapshot.docs.first.id;
    } else {
      throw "Allotment not found.";
    }

    // Step 5: Add the new user document to the users collection
    return await userCollection.doc(uid).set({
      'userName': userName,
      'profilePic': profilePicPath,
      'town': townData,
      'allotment': allotmentData
    });
  }

  Future<UserProfile?> getUserProfile() async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        return UserProfile(
            userName: userDoc['userName'],
            profilePic: userDoc['profilePic'],
            town: userDoc['town'],
            allotment: userDoc['allotment']);
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
            profilePic: snapshot['profilePic'],
            town: snapshot['town'],
            allotment: snapshot['allotment']);
      } else {
        return null;
      }
    });
  }
}
