import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        String displayName = email.split('@')[0];
        debugPrint('Display name: $displayName');
        await credential.user!.updateDisplayName(displayName);
        await credential.user!.reload();
        return AppUser(
          uid: credential.user!.uid,
          email: credential.user!.email!,
          name: credential.user!.displayName!,
        );
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  // logging in
  static Future<AppUser?> signIn(String email, String password) async {
    try {
      final UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        return AppUser(
            uid: credential.user!.uid,
            email: credential.user!.email!,
            name: credential.user!.displayName!);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // logging out
  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
