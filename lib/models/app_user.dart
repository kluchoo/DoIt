import 'dart:typed_data';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppUser extends ChangeNotifier {
  String uid;
  String email = "null";
  String name = "null";
  Uint8List? photo;

  AppUser({required this.uid}) {
    // pobierz dane użytkownika z bazy danych
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (snapshot.data() == null) {
        // Brak dokumentu użytkownika
        debugPrint('Nie znaleziono dokumentu dla uid: $uid');
        return;
      }

      final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

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
}
