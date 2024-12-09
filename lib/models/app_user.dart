import 'dart:typed_data';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppUser extends ChangeNotifier {
  String uid;
  String email = "null";
  String name = "null";
  Uint8List? photo;

  AppUser({required this.uid, required this.email}) {
    // pobierz dane użytkownika z bazy danych
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
    } catch (e) {
      debugPrint('Błąd podczas pobierania danych użytkownika: $e');
      rethrow;
    }
  }

  Future<void> fetchUserAuthData() async {
    // pobierz dane użytkownika z bazy autentykacji danych
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
    uid = "";
    email = "";
    name = "";
    photo = null;
  }
}
