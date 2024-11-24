import 'package:flutter/material.dart';

class AppUser extends ChangeNotifier {
  AppUser({required this.uid, required this.email});

  final String uid;
  final String email;
}
