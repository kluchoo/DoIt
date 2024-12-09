import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> encode(String img) async {
    final ByteData bytes = await rootBundle.load(img);
    final List<int> bytesList = bytes.buffer.asUint8List();
    final String base64Image = base64Encode(bytesList);
    return base64Image;
  }

// sign up new users

  Future<AppUser?> signUp(String email, String password) async {
    try {
      final UserCredential credential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        String profileImg = await encode("assets/img/newuser.jpeg");
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set({"profileImg": profileImg, "watchedQuotes": 0});
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
