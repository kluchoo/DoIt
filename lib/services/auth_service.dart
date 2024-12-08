import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

// sign up new users

  static Future<AppUser?> signUp(String email, String password) async {
    try {
      final UserCredential credential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        return AppUser(
          uid: credential.user!.uid,
          email: credential.user!.email!,
        );
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc("${credential.user!.uid}")
          .set({"profileImg": "", "watchedQuotes": 0});

      return null;
    } catch (e) {
      return null;
    }
  }
}
