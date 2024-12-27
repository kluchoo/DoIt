import 'dart:typed_data';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_it/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppUser extends ChangeNotifier {
  String uid;
  String email;
  String name;
  Uint8List? photo;

  AppUser({required this.uid, required this.email, required this.name}) {
    // pobierz dane użytkownika z bazy danych
  }

  void update(AppUser user) {
    uid = user.uid;
    email = user.email;
    name = user.name;
    photo = user.photo;
    notifyListeners();
  }

  Future<int> dayStrikeUpdate() async {
    try {
      // pobierz aktualną datę
      final lastSignIn = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((value) => value.get('LastSignIn'));
      final lastSignInDateTime = (lastSignIn as Timestamp).toDate();

      // sprawdź czy dzisiaj jest dniem większym o jeden od ostatniego logowania
      final now = DateTime.now();
      final lastSignInDate = DateTime(lastSignInDateTime.year,
          lastSignInDateTime.month, lastSignInDateTime.day);
      final today = DateTime(now.year, now.month, now.day);
      final difference = today.difference(lastSignInDate).inDays;

      if (difference == 1) {
        // jeśli tak to zwiększ licznik dni
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update({"dayStrike": FieldValue.increment(1)});

        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update({"LastSignIn": DateTime.now()});
      } else if (difference > 1) {
        // jeśli nie to zresetuj licznik dni
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update({"dayStrike": 1});

        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update({"LastSignIn": DateTime.now()});
      }

      // pobierz aktualny licznik dni
      final dayStrike = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((value) => value.get('dayStrike'));

      return dayStrike as int;
    } catch (e) {
      debugPrint('Błąd podczas aktualizacji dayStrike: $e');
      if (e is StateError &&
          e.message.contains('field "LastSignIn" does not exist')) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .set({"LastSignIn": DateTime.now()});
      } else {
        rethrow;
      }
    }
    return 0;
  }

  Future<void> fetchUserAuthData() async {
    // pobierz dane użytkownika z autoryzacji
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final User? user = _firebaseAuth.currentUser;
    name = user!.displayName!;
    email = user.email!;
  }

  Future<void> fetchUserData() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      final data = snapshot.data();
      if (data == null) {
        debugPrint('Dane użytkownika są null');
        return;
      }

      // Bezpieczne przypisanie photo
      if (data.containsKey('profileImg') && data['profileImg'] != null) {
        try {
          String base64String = data['profileImg'] as String;
          photo = base64Decode(base64String);
          notifyListeners();
        } catch (e) {
          debugPrint('Błąd konwersji danych zdjęcia: $e');
          photo = null;
        }
      }

      // Bezpieczne przypisanie name
    } catch (e) {
      debugPrint('Błąd podczas pobierania danych użytkownika: $e');
      rethrow;
    }
  }

  Future<String> encode(String img) async {
    final ByteData bytes = await rootBundle.load(img);
    final List<int> bytesList = bytes.buffer.asUint8List();
    final String base64Image = base64Encode(bytesList);
    return base64Image;
  }

  Future<void> addNewUsersDocument() async {
    try {
      String profileImg = await encode("assets/img/newuser.jpeg");
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set({"profileImg": profileImg, "watchedQuotes": 0});
      debugPrint('Utworzono dokumentu dla uid: $uid');
    } catch (e) {
      debugPrint('Błąd podczas tworzenia dokumentu użytkownika: $e');
      rethrow;
    }
  }

  Future<void> logOut() async {
    // wyloguj użytkownika
    await AuthService.signOut();
    uid = "";
    email = "";
    name = "";
    photo = null;
  }
}
