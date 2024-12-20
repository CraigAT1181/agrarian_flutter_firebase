import 'package:firebase_auth/firebase_auth.dart';
import 'package:agrarian/models/user.dart';

class AuthService {
  // Create a variable to hold an instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Return our custom User class for each non-null Firebase User returned
  AgrarianUser? _agrarianUser(User? user) {
    return user != null ? AgrarianUser(uid: user.uid) : null;
  }

  // Stream to notify of each auth change of an AgrarianUser
  Stream<AgrarianUser?> get user {
    return _auth.authStateChanges().map(_agrarianUser);
  }

  // Function: Register
  Future<AgrarianUser?> register(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      return _agrarianUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Function: Sign in anonymously
  Future<AgrarianUser?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();

      User? user = result.user;

      return _agrarianUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Function: Sign in with email and password
  Future<AgrarianUser?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      return _agrarianUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Function: Sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
