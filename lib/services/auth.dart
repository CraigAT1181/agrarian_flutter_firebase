import 'package:firebase_auth/firebase_auth.dart';
import 'package:agrarian/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AgrarianUser? _agrarianUser(User? user) {
    return user != null ? AgrarianUser(uid: user.uid) : null;
  }

  Stream<AgrarianUser?> get user {
    return _auth.authStateChanges().map(_agrarianUser);
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();

      User? user = result.user;

      return _agrarianUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
