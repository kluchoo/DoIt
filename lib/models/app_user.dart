import 'package:flutter/material.dart';

class AppUser extends ChangeNotifier {
  AppUser({required this.uid, required this.email, required this.name});

  final String uid;
  final String email;
  final String name;
}
